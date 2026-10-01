---
name: daily-sync
description: "Draft and post Prashant's daily update to Zulip #Labs > Daily Sync. Gathers peer-session summaries, runs the daily-sync agent, shows the draft, posts on explicit approval."
---

Run the daily-sync flow. Four steps, in order. Do not skip the approval gate.

## 1. Ask live peer sessions (optional source)

Call `ListAgents`. For every peer session on this machine other than yourself,
send with `SendMessage`:

> Please send back a short summary of what you did today for a Zulip daily-sync
> update: what shipped or changed (commits, branches, MRs, Linear issues), what
> was decided, what is open or blocked. 5-10 bullets, plain factual language.
> Reply via SendMessage.

Replies arrive in this conversation at your next tool round. Wait one tool
round (a cheap read such as `git status` is fine). If a peer is busy, do not
wait more than two rounds; proceed with whatever arrived and note who did not
reply. If there are no peers, skip this step and say so.

## 2. Run the agent

Launch the `daily-sync` agent with the Agent tool. The prompt is:

> Draft today's Daily Sync update. Today is <YYYY-MM-DD>.
> Peer session summaries follow; verify every claim before use.
> <paste each reply verbatim, labelled by session name, or "No peer input.">

Wait for its report.

## 3. Show the draft and stop

Show the user the report's DRAFT section verbatim, then the UNVERIFIED and
CHANGES SINCE LAST POST sections. Do not post. End your turn and wait for the
user to say go, or to give edits. Apply edits to the draft text exactly as
given; do not re-run the agent for wording changes.

## 4. Post on explicit approval only

"Post it", "go", "ship it" or equivalent is approval. Anything else is not.
Write the approved text to a file in the scratchpad directory, then post with
the Zulip API using the credentials in `~/.zuliprc`:

```bash
EMAIL=$(sed -n 's/^email=//p' ~/.zuliprc); KEY=$(sed -n 's/^key=//p' ~/.zuliprc); SITE=$(sed -n 's/^site=//p' ~/.zuliprc)
curl -sS -u "$EMAIL:$KEY" -X POST "$SITE/api/v1/messages" \
  --data-urlencode type=stream --data-urlencode to=Labs \
  --data-urlencode topic="Daily Sync" --data-urlencode content@<draft-file>
```

Report the returned message URL. If the response is not `"result":"success"`,
show the full response and stop.

If the user corrected the draft, tell the `daily-sync` agent what was
corrected and why (one `SendMessage` to it) so it records the correction in
its memory.
