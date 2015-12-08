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
alias artisan='php artisan'

## editor support
alias sublime-text='/opt/sublime_text/sublime_text'
alias nginx-configuration='vim /etc/nginx/sites-available/default'
alias nginx-restart='service nginx restart'

## project
alias code='cd /home/vu/Code; clear; ls -l'
alias project-laravel='cd /home/vu/Code/laravel; clear; ls -l'
alias project-git='cd /home/vu/Code/git; clear; ls -l'

## cleaner your system
alias cleaner='/home/vu/.ihavesys/exec/clean.sh'
alias quit='clear;/home/vu/.ihavesys/exec/quit'

## more
alias node='nodejs'
alias nano='clear; /home/vu/.ihavesys/exec/nano'

## support
alias speed-test='speedtest-cli --simple'