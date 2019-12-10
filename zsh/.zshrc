# Disable auto correct
unsetopt correct_all
unsetopt correct

#ZSH_THEME="eastwood-custom"
ZSH_THEME="avit-improved"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git archlinux docker autojump zsh-autosuggestions zsh-syntax-highlighting
)

[ -d ~/.oh-my-zsh ] && export ZSH=~/.oh-my-zsh

typeset -a sources
sources+=$ZSH/oh-my-zsh.sh
sources+=/usr/share/autojump/autojump.sh
sources+=~/.zsh_env
sources+=~/.zsh_env_work
sources+=~/.zsh_fzf
sources+=~/.zsh_misc
sources+=~/.zsh_git
sources+=~/.zsh_docker
sources+=~/.zsh_emby
sources+=~/.zsh_consul
sources+=~/.zsh_nomad
sources+=~/.zsh_terraform
sources+=~/.zsh_systemd
sources+=~/.zsh_ansible

for file in $sources[@]; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done

if [ "$(tty)" = "/dev/tty1" -o "$(tty)" = "/dev/vc/1" ] ; then
  startxfce4
fi
