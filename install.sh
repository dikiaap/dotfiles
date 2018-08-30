#!/usr/bin/env bash

blue='\e[1;34m'
red='\e[1;31m'
white='\e[0;37m'

CMD="$1"
dotfilesdir=$(pwd)
backupdir=~/.dotfiles.orig
dotfiles=(.i3 .zsh .aliases .bash_profile .bash_prompt .bashrc .dircolors .editorconfig .exports .functions .gemrc .ripgreprc .tmux.conf .wgetrc .Xresources .zshrc)
dotfiles_config=(.alacritty .compton .dunst .htop .i3blocks .rofi)

printusage() {
    prog=$(basename "$0")
    echo "Usage: $prog [-option]" >&2
    echo "" >&2
    echo "Options:" >&2
    echo "    --help    Print this message" >&2
    echo "    -i        Install all config" >&2
    echo "    -r        Restore old config" >&2
}

install() {
    # Backup config.
    if ! [ -f $backupdir/check-backup.txt ]; then
        mkdir -p $backupdir/.config
        cd $backupdir
        touch check-backup.txt

        # Backup to ~/.dotfiles.orig
        for dots in "${dotfiles[@]}"
        do
            /bin/cp -rf ~/${dots} $backupdir &> /dev/null
        done

        # Backup some folder in ~/.config to ~/.dotfiles.orig/.config
        for dots_conf in "${dotfiles_config[@]//./}"
        do
            /bin/cp -rf ~/.config/${dots_conf} $backupdir/.config &> /dev/null
        done

        # Backup again with Git.
        git init &> /dev/null
        git add -u &> /dev/null
        git add . &> /dev/null
        git commit -m "Backup original config on `date '+%Y-%m-%d %H:%M'`" &> /dev/null

        # Output.
        echo -e $blue"Your config is backed up in "$backupdir"\n" >&2
        echo -e $red"Please do not delete check-backup.txt in .dotfiles.orig folder."$white >&2
        echo -e "It's used to backup and restore your old config.\n" >&2
    fi

    # Install config.
    for dots in "${dotfiles[@]}"
    do
        /bin/rm -rf ~/${dots}
        /bin/ln -fs "$dotfilesdir/${dots}" ~/
    done

    # Install config to ~/.config.
    mkdir -p ~/.config
    for dots_conf in "${dotfiles_config[@]}"
    do
        /bin/rm -rf ~/.config/${dots_conf[@]//./}
        /bin/ln -fs "$dotfilesdir/${dots_conf}" ~/.config/${dots_conf[@]//./}
    done

    echo -e $blue"New dotfiles is installed!\n"$white >&2
    echo "There may be some errors when Terminal is restarted." >&2
    echo "Please read carefully the error messages and make sure all packages are installed. See more info in README.md." >&2
    echo "Note that the author of this dotfiles uses dev branch in some packages." >&2
    echo -e "If you want to restore your old config, you can use "$red"./install.sh -r"$white" command." >&2
}

uninstall() {
    if [ -f $backupdir/check-backup.txt ]; then
        for dots in "${dotfiles[@]}"
        do
            /bin/rm -rf ~/${dots}
            /bin/cp -rf $backupdir/${dots} ~/ &> /dev/null
            /bin/rm -rf $backupdir/${dots}
        done

        for dots_conf in "${dotfiles_config[@]//./}"
        do
            /bin/rm -rf ~/.config/$dots_conf
            /bin/cp -rf $backupdir/.config/${dots_conf} ~/.config &> /dev/null
            /bin/rm -rf $backupdir/.config/${dots_conf}
        done

        # Save old config in backup directory with Git.
        cd $backupdir &> /dev/null
        git add -u &> /dev/null
        git add . &> /dev/null
        git commit -m "Restore original config on `date '+%Y-%m-%d %H:%M'`" &> /dev/null
    fi

    if ! [ -f $backupdir/check-backup.txt ]; then
        echo -e $red"You have not installed this dotfiles yet."$white >&2
    else
        echo -e $blue"Your old config has been restored!\n"$white >&2
        echo "Thanks for using my dotfiles." >&2
        echo "Enjoy your next journey!" >&2
    fi

    /bin/rm -rf $backupdir/check-backup.txt
}

if [[ -z "$1" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    printusage
    exit 0
fi

case "$CMD" in
    -i)
        install
        ;;
    -r)
        uninstall
        ;;
    *)
        echo "Command not found" >&2
        exit 1
esac
