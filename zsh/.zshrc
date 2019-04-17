# Disable auto correct
unsetopt correct_all
unsetopt correct

#ZSH_THEME="eastwood-custom"
ZSH_THEME="avit-improved"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git archlinux docker autojump zsh-autosuggestions zsh-syntax-highlighting
)

# source environment
[ -f ~/.zsh_env ] && source ~/.zsh_env

# source oh-my-zsh
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

# source misc config
[ -f ~/.zsh_misc ] && source ~/.zsh_misc

# source git config
[ -f ~/.zsh_git ] && source ~/.zsh_git

# source docker config
[ -f ~/.zsh_docker ] && source ~/.zsh_docker

# source emby config
[ -f ~/.zsh_emby ] && source ~/.zsh_emby

# source nomad config
[ -f ~/.zsh_nomad ] && source ~/.zsh_nomad
