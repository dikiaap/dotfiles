#!/usr/bin/env bash

blue='\e[1;34m'
red='\e[1;31m'
white='\e[0;37m'
dotfiles_repo_dir=$(pwd)
backup_dir="$HOME/.dotfiles.orig"
dotfiles_home_dir=(.zsh .aliases .bash_profile .bashrc .dircolors .editorconfig .exports
                   .functions .gemrc .ripgreprc .tmux.conf .wgetrc .Xresources .zshrc)
dotfiles_xdg_config_dir=(.alacritty .dunst .htop .i3 .i3blocks .picom .rofi)

# Print usage message.
usage() {
    local program_name
    program_name=${0##*/}
    cat <<EOF
Usage: $program_name [-option]

Options:
    --help    Print this message
    -i        Install all config
    -r        Restore old config
EOF
}

install_dotfiles() {
    # Backup config.
    if ! [ -f "$backup_dir/check-backup.txt" ]; then
        mkdir -p "$backup_dir/.config"
        cd "$backup_dir" || exit
        touch check-backup.txt

        # Backup to ~/.dotfiles.orig
        for dots_home in "${dotfiles_home_dir[@]}"
        do
            env cp -rf "$HOME/${dots_home}" "$backup_dir" &> /dev/null
        done

        # Backup some folder in ~/.config to ~/.dotfiles.orig/.config
        for dots_xdg_conf in "${dotfiles_xdg_config_dir[@]//./}"
        do
            env cp -rf "$HOME/.config/${dots_xdg_conf}" "$backup_dir/.config" &> /dev/null
        done

        # Backup again with Git.
        if [ -x "$(command -v git)" ]; then
            git init &> /dev/null
            git add -u &> /dev/null
            git add . &> /dev/null
            git commit -m "Backup original config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
        fi

        # Output.
        echo -e "${blue}Your config is backed up in ${backup_dir}\n" >&2
        echo -e "${red}Please do not delete check-backup.txt in .dotfiles.orig folder.${white}" >&2
        echo -e "It's used to backup and restore your old config.\n" >&2
    fi

    # Install config.
    for dots_home in "${dotfiles_home_dir[@]}"
    do
        env rm -rf "$HOME/${dots_home}"
        env ln -fs "$dotfiles_repo_dir/${dots_home}" "$HOME/"
    done

    # Install config to ~/.config.
    mkdir -p "$HOME/.config"
    for dots_xdg_conf in "${dotfiles_xdg_config_dir[@]}"
    do
        env rm -rf "$HOME/.config/${dots_xdg_conf[*]//./}"
        env ln -fs "$dotfiles_repo_dir/${dots_xdg_conf}" "$HOME/.config/${dots_xdg_conf[*]//./}"
    done

    echo -e "${blue}New dotfiles is installed!\n${white}" >&2
    echo "There may be some errors when Terminal is restarted." >&2
    echo "Please read carefully the error messages and make sure all packages are installed. See more info in README.md." >&2
    echo "Note that the author of this dotfiles uses dev branch in some packages." >&2
    echo -e "If you want to restore your old config, you can use ${red}./install.sh -r${white} command." >&2
}

uninstall_dotfiles() {
    if [ -f "$backup_dir/check-backup.txt" ]; then
        for dots_home in "${dotfiles_home_dir[@]}"
        do
            env rm -rf "$HOME/${dots_home}"
            env cp -rf "$backup_dir/${dots_home}" "$HOME/" &> /dev/null
            env rm -rf "$backup_dir/${dots_home}"
        done

        for dots_xdg_conf in "${dotfiles_xdg_config_dir[@]//./}"
        do
            env rm -rf "$HOME/.config/${dots_xdg_conf}"
            env cp -rf "$backup_dir/.config/${dots_xdg_conf}" "$HOME/.config" &> /dev/null
            env rm -rf "$backup_dir/.config/${dots_xdg_conf}"
        done

        # Save old config in backup directory with Git.
        if [ -x "$(command -v git)" ]; then
            cd "$backup_dir" || exit
            git add -u &> /dev/null
            git add . &> /dev/null
            git commit -m "Restore original config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
        fi
    fi

    if ! [ -f "$backup_dir/check-backup.txt" ]; then
        echo -e "${red}You have not installed this dotfiles yet.${white}" >&2
        exit 1
    else
        echo -e "${blue}Your old config has been restored!\n${white}" >&2
        echo "Thanks for using my dotfiles." >&2
        echo "Enjoy your next journey!" >&2
    fi

    env rm -rf "$backup_dir/check-backup.txt"
}

main() {
    case "$1" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        -i)
            install_dotfiles
            ;;
        -r)
            uninstall_dotfiles
            ;;
        *)
            echo "Command not found" >&2
            exit 1
    esac
}

main "$@"
