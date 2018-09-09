# Load our dotfiles.
for file in ~/.{aliases,aliases_private,bash_prompt,exports,functions,functions_private}; do
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

# Bash completion.
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
fi

# dircolors.
if [ -x "$(command -v dircolors)" ]; then
    eval "$(dircolors -b ~/.dircolors)"
fi

# Manage SSH with Keychain.
if [ -x "$(command -v keychain)" ]; then
    eval "$(keychain --eval --quiet id_rsa_github id_rsa_gitlab)"
fi

# Base16 Shell.
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"

# Start tmux.
if [[ -x "$(command -v tmux)" && "$(ps -o 'cmd=' -p $(ps -o 'ppid=' -p $$))" = "alacritty" ]]; then
    [ -z "$TMUX" ] && { tmux attach-session || exec tmux && exit; }
fi
