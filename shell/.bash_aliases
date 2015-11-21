# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# this is type of your aliases
# you can add everything about shortcut in terminal
# so, got it! >.>

## laravel mind
alias laravel='/home/vu/.composer/vendor/bin/laravel'
alias lumen='/home/vu/.composer/vendor/bin/lumen'

## editor support
alias sublime-text='/opt/sublime_text/sublime_text'
alias nginx-configuration='sublime-text /etc/nginx/sites-available/default'

## project
alias project-laravel='cd /home/vu/LibsCode/Laravel; c; ls -l'
alias project-git='cd /home/vu/LibsCode/Git; c; ls -l'

## cleaner your system
alias cleaner='/home/vu/.ihavesys/clean.sh'
alias c='clear'

## more
alias pentest='/home/vu/.ihavesys/pentest'
alias node='nodejs'

