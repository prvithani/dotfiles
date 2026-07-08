# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

function ensure_in_path() {
  location="$1"
  segment="$2"
  if [[ "$PATH" != *"$segment"* ]]; then
    if [[ "$location" = "SUFFIX" ]]; then
      export PATH="$PATH:$segment"
    elif [[ "$location" = "PREFIX" ]]; then
      export PATH="$segment:$PATH"
    else
      echo -e "Syntax: ensure_in_path {SUFFIX|PREFIX} [SEGMENT]\nGOT: $@" >&2
    fi
  fi
}

vterm_printf() {
    if [ -n "$TMUX" ] \
        && { [ "${TERM%%-*}" = "tmux" ] \
            || [ "${TERM%%-*}" = "screen" ]; }; then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

if [[ $(uname -s) == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ensure_in_path PREFIX "/opt/homebrew/opt/grep/libexec/gnubin"
    ensure_in_path PREFIX "/opt/homebrew/opt/openjdk/bin"
fi

if [ -d $HOME/.config/emacs/bin ]; then
    ensure_in_path PREFIX "$HOME/.config/emacs/bin"
fi

if [ -d $HOME/.local/bin ]; then
    ensure_in_path PREFIX "$HOME/.local/bin"
fi

if [[ -z $SSH_TTY ]]
then
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
      export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi
fi

if [ -d $HOME/.jdtls/eclipse.jdt.ls ]; then
    ensure_in_path SUFFIX "$HOME/.jdtls/eclipse.jdt.ls/bin"
fi

if [ -d $HOME/.local/share/coursier ]; then
    ensure_in_path SUFFIX "$HOME/.local/share/coursier/bin"
fi

if [ -d $HOME/.rbenv/bin ]; then
    # Added by `rbenv init` on Fri Sep 27 19:26:54 UTC 2024
    eval "$($HOME/.rbenv/bin/rbenv init - --no-rehash bash)"
else
    if type rbenv &>/dev/null
    then
        eval "$(rbenv init - --no-rehash bash)"
    fi
fi

if [ -f $HOME/.cargo/env ]; then
    . $HOME/.cargo/env
fi

export RUBY_YJIT_ENABLE=1

if type fzf &>/dev/null
then
    eval "$(fzf --bash)"
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

# EMACS Settings
export LSP_USE_PLISTS=true

# If not running interactively, don't do anything
# [ -z "$PS1" ] && return
[[ $- != *i* ]] && return

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$arch_chroot" ] && [ -r /etc/arch_chroot ]; then
    arch_chroot=$(cat /etc/arch_chroot)
fi

# # set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    *-256color) color_prompt=256;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ -d /usr/share/git/completion ]
then
    source /usr/share/git/completion/git-prompt.sh
fi
export GIT_PS1_SHOWDIRTYSTATE=1

# Highlight the user name when logged in as root.
#if [[ "${USER}" == "root" ]]; then
#	userStyle='\[\033[01;31m\]';
#else
#	userStyle='\[\033[01;32m\]';
#fi;

if [ "$color_prompt" = true ]; then
    PS1='${arch_chroot:+($arch_chroot)}\[\033[38;2;192;255;0m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[38;2;192;255;0m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
elif [ "$color_prompt" = yes ]; then
    # ORIGINAL
    #PS1='${arch_chroot:+($arch_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # ORIGNAL BUT RED
    #PS1='${arch_chroot:+($arch_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
    # CUSTOM 
    if [[ "${USER}" == "root" ]]; then
	    PS1='\n${arch_chroot:+($arch_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h\[\033[00m\]: \[\033[01;38;5;36m\]\w \[\033[38;5;32m\]$(__git_ps1 "(%s)")\n\[\033[01;35m\]\$ \[\033[00m\]'
    else
	    PS1='\n${arch_chroot:+($arch_chroot)}\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h\[\033[00m\]: \[\033[01;38;5;36m\]\w \[\033[38;5;32m\]$(__git_ps1 "(%s)")\n\[\033[01;35m\]\$ \[\033[00m\]'
    fi;
    # PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h\[\033[00m\]: \[\033[01;38;5;36m\]\w \[\033[38;5;32m\]$(__git_ps1 "(%s)")\n\[\033[01;35m\]\$ \[\033[00m\]'
    #PS1='\n${arch_chroot:+($arch_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h\[\033[00m\]: \[\033[01;38;5;36m\]\w\n\[\033[01;35m\]\$ \[\033[00m\]'
    #PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h\[\033[00m\]: \[\033[01;38;5;36m\]\w\n\[\033[01;35m\]\$ \[\033[00m\]'
else
    PS1='${arch_chroot:+($arch_chroot)}\u@\h:\w\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${arch_chroot:+($arch_chroot)}\u@\h: \w\a\]$PS1"
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Workspace/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/Workspace/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/Workspace/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/Workspace/google-cloud-sdk/completion.bash.inc"; fi

# Add tab completion for many Bash commands MacOS
if [[ $(uname -s) == "Darwin" ]]; then
    if type brew &>/dev/null
    then
      HOMEBREW_PREFIX="$(brew --prefix)"
      if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
      then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
      fi
      for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
      do
          [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
      done
    fi

    # MACOS settings
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Add tab completion for `defaults read|write NSGlobalDomain`
    # You could just use `-g` instead, but I like being explicit
    complete -W "NSGlobalDomain" defaults;

    # Add `killall` tab completion for common apps
    complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

    # Enable tab completion for `g` by marking it as an alias for `git`
    # if type _git &> /dev/null && [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
    # 	complete -o default -o nospace -F _git g;
    # fi;
fi
