# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Disable auto correct
unsetopt correct_all
unsetopt correct

#ZSH_THEME="eastwood-custom"
# ZSH_THEME="avit-improved"
COMPLETION_WAITING_DOTS="true"

# plugins=(
#     git archlinux docker autojump zsh-autosuggestions zsh-syntax-highlighting
# )
# export ZSH=~/.oh-my-zsh
# [ -d ~/.oh-my-zsh ] && export ZSH=~/.oh-my-zsh

typeset -a sources
# sources+=$ZSH/oh-my-zsh.sh
# sources+=/usr/share/autojump/autojump.sh
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
sources+=~/.p10k.zsh

for file in $sources[@]; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done

if [ "$(tty)" = "/dev/tty1" -o "$(tty)" = "/dev/vc/1" ] ; then
    startxfce4
fi

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

# zplugin
zplugin light zsh-users/zsh-completions
zplugin light zsh-users/zsh-autosuggestions
# zplugin light zsh-users/zsh-syntax-highlighting
zplugin light zsh-users/zsh-history-substring-search
zplugin light zdharma/fast-syntax-highlighting
zplugin light wfxr/forgit

# binaries
zplugin wait pack for fzf
# zplugin ice from"gh-r" as"program"
# zplugin load junegunn/fzf-bin

# load omz libraries
zplugin snippet OMZ::lib/git.zsh

# load omz plugins
zplugin snippet OMZ::plugins/autojump/autojump.plugin.zsh
zplugin snippet OMZ::plugins/docker/_docker
zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
# zplugin snippet OMZ::plugins/git/git.plugin.zsh
# zplugin snippet OMZ::plugins/vagrant/_vagrant
zplugin snippet OMZ::plugins/vscode/vscode.plugin.zsh
# zplugin snippet OMZ::plugins/zsh_reload/zsh_reload.plugin.zsh
zplugin cdclear -q # <- forget completions provided up to this moment

setopt promptsubst

# load normal github plugin with theme depending on omz git library
zplugin ice depth=1; zplugin light romkatv/powerlevel10k

# zplugin light oh-my-zsh
# zplugin light oh-my-zsh plugins/docker
# zplugin light oh-my-zsh plugins/autojump

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh