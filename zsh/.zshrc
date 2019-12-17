# enable powerlevel10k instant prompt. should stay close to the top of ~/.zshrc.
# initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history settings
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history           # append to histfile instead of overwriting
setopt hist_expire_dups_first   # prune duplicate commands before unique from history
setopt hist_ignore_space        # remove commands with starting whitespace from history
setopt share_history            # append and import history between terminals

# disable auto correct
unsetopt correct                # do not autocorrect command
unsetopt correct_all            # do not autocorrect all args

# other zsh options
setopt auto_cd                  # auto cd if input is not a command
setopt auto_menu                # automatically use menu completion
setopt always_to_end            # move cursor to end if word had one match

# add menu selection with arrow for completion
zstyle ':completion:*' menu select

typeset -a sources
sources+=$HOME/.zsh_bindkeys
sources+=$HOME/.zsh_env
sources+=$HOME/.zsh_env_work
sources+=$HOME/.zsh_fzf
sources+=$HOME/.zsh_misc
sources+=$HOME/.zsh_git
sources+=$HOME/.zsh_docker
sources+=$HOME/.zsh_consul
sources+=$HOME/.zsh_nomad
sources+=$HOME/.zsh_terraform
sources+=$HOME/.zsh_systemd
sources+=$HOME/.zsh_ansible

for file in $sources[@]; do
    [ -s "$file" ] && source "$file"
done

if [[ $TTY == /dev/(tty|vc)1 ]]; then
    startxfce4
fi

if [ ! -d $HOME/.zplugin ]; then
    echo "zplugin missing, installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

#=========
# zplugin
#=========
zplugin light jreese/zsh-titles
zplugin light zsh-users/zsh-completions
zplugin light zsh-users/zsh-autosuggestions
zplugin light-mode atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" for zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-history-substring-search
zplugin light wfxr/forgit

# binaries
zplugin wait pack for fzf

# load omz libraries
zplugin snippet OMZ::lib/git.zsh

# load omz plugins
zplugin snippet OMZ::plugins/autojump/autojump.plugin.zsh
zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zplugin snippet OMZ::plugins/vscode/vscode.plugin.zsh

# load omz completions
zplugin ice as"completion"; zplugin snippet OMZ::plugins/docker/_docker
zplugin ice as"completion"; zplugin snippet OMZ::plugins/vagrant/_vagrant
zplugin cdclear -q # <- forget completions provided up to this moment

# load normal github plugin with theme depending on omz git library
zplugin ice depth=1; zplugin light romkatv/powerlevel10k

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
