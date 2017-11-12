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
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Base16 Shell
export BASE16_SHELL="$HOME/.config/base16-shell"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
