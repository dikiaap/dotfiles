# Load our dotfiles.
for file in ~/.{aliases,aliases_private,bash_prompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell;

# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob;

# Bash attempts to save all lines of a multiple-line command in the same history entry.
# This allows easy re-editing of multi-line commands.
shopt -s cmdhist;

# Check the window size after each command and, if necessary,
# update the values of lines and columns.
shopt -s checkwinsize;

# Gotta tune that bash_history.
# from paulirish.
export HISTTIMEFORMAT='%F %T '
# keep history up to date, across sessions, in realtime
# http://unix.stackexchange.com/a/48113
export HISTCONTROL=ignoredups:erasedups         # no duplicate entries
export HISTSIZE=2000                         	# big history (default is 1000)
export HISTFILESIZE=$HISTSIZE                   # big history
which shopt > /dev/null && shopt -s histappend  # append to history, don't overwrite it
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# ^ the only downside with this is [up] on the readline will go over all history not just this bash session.

# Completion.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi;
fi;

# Highlighting inside manpages and elsewhere.
# from paulirish.
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Added path heroku.
export PATH="/usr/local/heroku/bin:$PATH"
