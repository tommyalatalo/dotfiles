#!/bin/bash

echo "To be installed:"
printf "curl\ngit\nzsh\nautojump\noh-my-zsh\navit-improved theme\nzsh-syntax-highlighting\nzsh-autosuggestions\n"
printf "\nChoose OS package manager:\n"

PS3='Selection: '
options=("Arch Linux (pacman)" "Ubuntu/Debian (apt)" "Quit")
pkgman=""

select opt in "${options[@]}"
do
    case $opt in
        "Arch Linux (pacman)")
            echo "installing using pacman..."
            pkgman="pacman"
            sudo pacman -Syy
            sudo pacman -S curl git zsh autojump
            break
            ;;
        "Ubuntu/Debian (apt)")
            echo "installing using apt..."
            pkgman="apt"
            sudo apt update
            sudo apt install curl git zsh autojump
            break
            ;;
        "Quit")
            exit 0
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "installing .oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "installing zsh-autosuggestions..."
cd ~/.oh-my-zsh/plugins/ && git clone git@github.com:zsh-users/zsh-autosuggestions.git
echo "installing zsh-syntax-highlighting..."
cd ~/.oh-my-zsh/plugins/ && git clone git@github.com:zsh-users/zsh-syntax-highlighting.git
echo "installing avit-improved theme..."
cd ~/.oh-my-zsh/themes/ && git clone git@github.com:mikesprague/avit-zsh-theme-improved.git
cp ~/.oh-my-zsh/themes/avit-zsh-theme-improved/avit-improved.zsh-theme ~/.oh-my-zsh/themes/
echo "finished installation, log out to update"

