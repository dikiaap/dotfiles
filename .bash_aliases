# this is type of your aliases
# you can add everything about alias in your shell
# so, got it! >.>

## laravel application
alias artisan='php artisan'
alias laravel='~/.composer/vendor/bin/laravel'
alias lumen='~/.composer/vendor/bin/lumen'

## editor, server & config
alias sublime-text='/opt/sublime_text/sublime_text'
alias nginx-configuration='sudo subl /etc/nginx/sites-available/default'
alias nginx-restart='sudo service nginx restart'
alias nginx-start='sudo service nginx start'
alias nginx-stop='sudo service nginx stop'
alias nginx-status='sudo service nginx status'
alias fpm-restart='sudo service php5-fpm restart'
alias fpm-start='sudo service php5-fpm start'
alias fpm-stop='sudo service php5-fpm stop'
alias fpm-status='sudo service php5-fpm status'
alias mysql-restart='sudo service mysql restart'
alias mysql-start='sudo service mysql start'
alias mysql-stop='sudo service mysql stop'
alias mysql-status='sudo service mysql status'

## go to project
alias code='cd ~/Code; clear; ls -l'
alias project-laravel='cd ~/Code/laravel/project; clear; ls -l'
alias project-github='cd ~/Code/git/github; clear; ls -l'
alias project-gitlab='cd ~/Code/git/gitlab; clear; ls -l'
alias project-bitbucket='cd ~/Code/git/bitbucket; clear; ls -l'

## binary system
alias cleaner='~/.ihavesys/exec/clean.sh'
alias quit='clear; ~/.ihavesys/exec/quit'
alias python='python3.4'
alias node='nodejs'
alias nano='clear; ~/.ihavesys/exec/nano'

## more to minify
alias ..='cd ..'
alias usetor='proxychains'
alias lsd='ls -l | grep "^d"'
alias disk-report='df -P -kHl'
alias update-dev='echo -e "\n Updating Composer ... \n"; sudo composer self-update; echo -e "\n Updating Gem System ... \n"; sudo gem update --system; echo -e "\n Updating Gem ... \n"; sudo gem update; echo -e "\n Updating PHP-CS-FIXER ... \n"; sudo php-cs-fixer self-update; echo -e "\n Updating Symfony Installer ... \n"; sudo symfony self-update; echo -e "\n Updating NPM ... \n"; sudo npm install npm -g;'
alias update-sys='echo -e "\n Updating Package Elementary OS ... \n"; sudo apt-get update; echo -e "\n Updating Youtube Downloader ... \n"; sudo youtube-dl -U'
alias cleanup-dev='echo -e "\n Cleaning Gem ... \n"; sudo gem cleanup; echo -e "\n Cleaning Cache Composer ... \n"; sudo rm ~/.composer/2016*'
alias cleanup-sys='echo -e "\n Cleaning Package ... \n"; sudo apt-get clean; echo -e "\n Autoleaning Package ... \n"; sudo apt-get autoclean; echo -e "\n Autoremoving Package ... \n"; sudo apt-get autoremove'

## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
