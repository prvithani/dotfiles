#!/usr/bin/env python3
"""PreToolUse guard for Bash: enforces git/glab/ssh-add/system-dir rules.

deny  -> Claude must fix the command (message format, staging, MR flag, ssh-add).
ask   -> the user decides (any push, a commit on master/main, writes to /usr/local/lib).
Run with --test for the self-test.
"""
import json, os, re, shlex, subprocess, sys

PROTECTED = {"master", "main"}
TITLE_MAX, BODY_MAX = 60, 80
CLAUDE_LINE = re.compile(r"co-authored-by:.*claude|generated (with|by) \[?claude", re.I)
HEREDOC = re.compile(r"<<-?\s*(['\"]?)(\w+)\1[^\n]*\n(.*?)\n\s*\2\s*(?:\n|$)", re.S)


def segments(cmd):
    """Split a command into simple commands, heredoc bodies removed."""
    flat = HEREDOC.sub(lambda m: m.group(0).split("\n", 1)[0] + "\n", cmd)
    for part in re.split(r"&&|\|\||;|\||\n|\$\(|\)", flat):
        try:
            words = shlex.split(part, comments=True)
        except ValueError:
            words = part.split()
        if words:
            yield words


def git_args(words):
    """('sub', args, -C dir) for a git invocation, else None."""
    while words and re.match(r"^\w+=", words[0]):
        words = words[1:]
    if not words or os.path.basename(words[0]) != "git":
        return None
    i, cdir = 1, None
    while i < len(words) and words[i].startswith("-"):
        if words[i] == "-C" and i + 1 < len(words):
            cdir = words[i + 1]; i += 2
        elif words[i] in ("-c",):
            i += 2
        else:
            i += 1
    return (words[i], words[i + 1:], cdir) if i < len(words) else None


def branch(d):
    try:
        return subprocess.run(["git", "-C", d, "branch", "--show-current"],
                              capture_output=True, text=True, timeout=5).stdout.strip()
    except Exception:
        return ""


def commit_messages(cmd, d):
    """Messages of each `git commit` in cmd: heredoc body, -m values, or -F file."""
    out = []
    for m in re.finditer(r"\bgit\b[^\n;&|]*?\bcommit\b", cmd):
        rest = cmd[m.end():]
        line = rest.split("\n", 1)[0]
        h = HEREDOC.search(rest)
        if h and "<<" in line:
            out.append(h.group(3)); continue
        try:
            words = shlex.split(line)
        except ValueError:
            words = line.split()
        msgs, f = [], None
        for i, w in enumerate(words):
            if w in ("-m", "--message") and i + 1 < len(words):
                msgs.append(words[i + 1])
            elif w.startswith("--message="):
                msgs.append(w.split("=", 1)[1])
            elif w in ("-F", "--file") and i + 1 < len(words) and words[i + 1] != "-":
                f = words[i + 1]
        if msgs:
            out.append("\n\n".join(msgs))
        elif f:
            try:
                out.append(open(os.path.join(d, f)).read())
            except OSError:
                pass
    return out


def message_problems(msg):
    lines = msg.strip("\n").split("\n")
    probs = []
    if lines and len(lines[0]) > TITLE_MAX:
        probs.append(f"title is {len(lines[0])} chars (max {TITLE_MAX}): {lines[0]!r}")
    long = [l for l in lines[1:] if len(l) > BODY_MAX and " " in l.strip()]
    if long:
        probs.append(f"{len(long)} body line(s) over {BODY_MAX} chars, e.g. {long[0][:90]!r}")
    if CLAUDE_LINE.search(msg):
        probs.append("message carries a Claude co-author/Generated line")
    return probs


def check(cmd, cwd):
    cmd = cmd.replace("\\\n", " ")  # join line continuations
    deny, ask = [], []
    d = cwd
    for words in segments(cmd):
        if words[0] == "cd" and len(words) > 1:
            d = os.path.normpath(os.path.join(d, os.path.expanduser(words[1])))
            continue
        g = git_args(words)
        if g:
            sub, args, cdir = g
            gd = os.path.normpath(os.path.join(d, cdir)) if cdir else d
            if sub == "add":
                for a in args:
                    if a in ("-A", "--all", ".", ":/", "*") or re.match(r"^-[a-zA-Z]*A", a):
                        deny.append(f"`git add {a}` stages everything; stage explicit paths")
                    elif not a.startswith("-") and ".claude/plans" in a:
                        deny.append(f"`git add {a}`: plans in .claude/plans are never committed")
                    elif not a.startswith("-") and os.path.isdir(os.path.join(gd, a)):
                        deny.append(f"`git add {a}` adds a directory; stage explicit paths")
            elif sub == "commit":
                if any(a == "--all" or re.match(r"^-[a-zA-Z]*a[a-zA-Z]*$", a) for a in args):
                    deny.append("`git commit -a` stages every tracked change; stage explicit paths")
                if branch(gd) in PROTECTED:
                    ask.append(f"commit on {branch(gd)} in {gd}")
            elif sub == "push":
                refs, skip = [], False
                for a in args:
                    if skip: skip = False; continue
                    if a in ("-o", "--push-option", "--repo", "--receive-pack", "--exec"): skip = True; continue
                    if not a.startswith("-"): refs.append(a)
                targets = [r.split(":")[-1].replace("refs/heads/", "") for r in refs[1:]]
                hit = [t for t in targets if t in PROTECTED] or ([branch(gd)] if not targets and branch(gd) in PROTECTED else [])
                ask.append(f"push to {hit[0]} (protected) from {gd}" if hit else f"push from {gd}: {' '.join(words[1:])[:120]}")
            continue
        if words[0] == "glab" and words[1:3] == ["mr", "create"] and "--remove-source-branch" not in words:
            deny.append("`glab mr create` needs --remove-source-branch")
        flags = [w for w in words[1:] if w.startswith("-")]
        if words[0] == "ssh-add" and not (flags and all(f in ("-l", "-L", "-T") for f in flags)):
            deny.append("ssh-add may only run read-only (-l, -L, -T)")
        if words[0] in ("cp", "mv", "install", "ln", "rsync") and len(words) > 1 and words[-1].startswith("/usr/local/lib"):
            ask.append(f"writes into /usr/local/lib: {' '.join(words)[:120]}")
        if words[0] == "tee" and any(w.startswith("/usr/local/lib") for w in words[1:]):
            ask.append("tee into /usr/local/lib")
    if re.search(r">\s*/usr/local/lib", cmd):
        ask.append("redirect into /usr/local/lib")
    for msg in commit_messages(cmd, d):
        deny += message_problems(msg)
    return deny, ask


def main():
    data = json.load(sys.stdin)
    cmd = data.get("tool_input", {}).get("command", "")
    if not re.search(r"\b(git|glab|ssh-add)\b|/usr/local/lib", cmd):
        return
    deny, ask = check(cmd, data.get("cwd") or os.getcwd())
    if deny or ask:
        print(json.dumps({"hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "deny" if deny else "ask",
            "permissionDecisionReason": "git-guard: " + "; ".join(deny or ask)}}))


def test():
    import tempfile
    repo = tempfile.mkdtemp()
    subprocess.run(["git", "init", "-q", "-b", "main", repo], check=True)
    os.makedirs(os.path.join(repo, "src"))
    feat = tempfile.mkdtemp()
    subprocess.run(["git", "init", "-q", "-b", "feat", feat], check=True)
    ok_msg = "git commit -q -F - <<'EOF'\nfix: short title\n\nBody line.\nEOF"
    cases = [
        # (command, cwd, expected decision)
        (f"cd {feat} && git add src/a.clj b.clj", "/", None),
        (f"cd {feat} && git add -A", "/", "deny"),
        (f"git -C {feat} add .", "/", "deny"),
        (f"cd {repo} && git add src", "/", "deny"),
        (f"cd {feat} && git add .claude/plans/x.md", "/", "deny"),
        (f"cd {feat} && {ok_msg}", "/", None),
        (f"cd {repo} && {ok_msg}", "/", "ask"),
        (f"cd {feat} && git commit -m 'feat: " + "x" * 60 + "'", "/", "deny"),
        (f"cd {feat} && git commit -m \"$(cat <<'EOF'\nfix: ok\n\n" + "word " * 20 + "\nEOF\n)\"", "/", "deny"),
        (f"cd {feat} && git commit -q -F - <<'EOF'\nfix: ok\n\nCo-Authored-By: Claude Opus <noreply@anthropic.com>\nEOF", "/", "deny"),
        (f"cd {feat} && git commit -am 'fix: ok'", "/", "deny"),
        (f"cd {feat} && git commit --amend --no-edit", "/", None),
        (f"cd {feat} && git push -u origin feat -o merge_request.target=main", "/", "ask"),
        (f"cd {feat} && git push origin HEAD:main", "/", "ask"),
        ("git log origin/main..HEAD", "/", None),
        ("glab mr create --title x --target-branch main", "/", "deny"),
        ("glab mr create --title x --remove-source-branch", "/", None),
        ("glab mr create --title x \\\n  --remove-source-branch", "/", None),
        ("ssh-add -l", "/", None),
        ("ssh-add -T ~/.ssh/id.pub", "/", None),
        ("ssh-add ~/.ssh/id_ed25519", "/", "deny"),
        ("ssh-add -D", "/", "deny"),
        ("cp build/libdaffy.so /usr/local/lib/", "/", "ask"),
        ("ln -sf /usr/local/lib/libdaffy.so /root/.local/x.so", "/", None),
        ("LD_LIBRARY_PATH=/usr/local/lib clj -M:dev -e nil", "/", None),
        ("echo hi > /usr/local/lib/x", "/", "ask"),
    ]
    bad = 0
    for cmd, cwd, want in cases:
        deny, ask = check(cmd, cwd)
        got = "deny" if deny else "ask" if ask else None
        if got != want:
            bad += 1
            print(f"FAIL want={want} got={got} :: {cmd[:90]!r} {deny or ask}")
    print(f"{len(cases) - bad}/{len(cases)} passed")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    test() if "--test" in sys.argv else main()
