# Load our dotfiles.
for file in ~/.{aliases,aliases_private,exports,functions,functions_private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell

# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob

# Bash attempts to save all lines of a multiple-line command in the same history entry.
# This allows easy re-editing of multi-line commands.
shopt -s cmdhist

# Check the window size after each command and, if necessary,
# update the values of lines and columns.
shopt -s checkwinsize

# Bash prompt.
if [ "$color_prompt" = yes ]; then
    PS1='\n\[\e[36m\]\w$(__git_ps1 "\[\033[00m\] on \[\e[35m\] %s")\[\033[00m\]\n$ '
else
    PS1='\n\[\e[36m\]\w$(__git_ps1 "\[\033[00m\] on \[\e[35m\] %s")\[\033[00m\]\n$ '
fi
unset color_prompt force_color_prompt

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
if [ -f ~/.local/bin/base16-oxide ]; then
    source ~/.local/bin/base16-oxide
fi
