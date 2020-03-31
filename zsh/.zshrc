# enable powerlevel10k instant prompt. should stay close to the top of ~/.zshrc.
# initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# install p10k fonts if missing
typeset -A fonts
fonts=(
    "$HOME/.fonts/MesloLGS NF Regular.ttf" "https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf"
    "$HOME/.fonts/MesloLGS NF Bold.ttf" "https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf"
    "$HOME/.fonts/MesloLGS NF Italic.ttf" "https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf"
    "$HOME/.fonts/MesloLGS NF Bold Italic.ttf" "https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf"
)
for font url in ${(kv)fonts}; do
    [ ! -s "$font" ] && wget "${url}" --directory-prefix="$HOME/.fonts/"
done

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

# set teminal title dynamically
function set-term-title-precmd() {
    emulate -L zsh
    print -rn -- $'\e]0;'$USER\@$HOST ${(V%):-'%~'}$'\a' >$TTY
}
function set-term-title-preexec() {
    emulate -L zsh
    print -rn -- $'\e]0;'$USER\@$HOST ${(V%)1}$'\a' >$TTY
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec set-term-title-preexec
add-zsh-hook precmd set-term-title-precmd
set-term-title-precmd

# source aliases etc
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
sources+=$HOME/.zsh_vagrant
sources+=$HOME/.zsh_systemd
sources+=$HOME/.zsh_ansible

for file in $sources[@]; do
    [ -s "$file" ] && source "$file"
done

#======================================
#               zinit
#======================================
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit/completions" "$ZPFX/bin" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
    print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light wfxr/forgit
zinit ice pick"misc/quitcd/quitcd.zsh" id-as"nnn-quitcd"; zinit light jarun/nnn

# binaries
zinit ice from"gh-r" as"program" mv"fzf -> $ZPFX/bin/fzf" pick"$ZPFX/bin/fzf"; zinit load junegunn/fzf-bin
zinit ice from"gh-r" as"program" mv"ripgrep*/rg -> $ZPFX/bin/rg" pick"$ZPFX/bin/rg"; zinit load BurntSushi/ripgrep
zinit ice from"gh-r" as"program" mv"exa* -> $ZPFX/bin/exa" pick"$ZPFX/bin/exa"; zinit load ogham/exa
zinit ice from"gh-r" as"program" mv"bat*/bat -> $ZPFX/bin/bat" pick"$ZPFX/bin/bat" bpick"*musl*"; zinit load sharkdp/bat
zinit ice from"gh-r" as"program" mv"nnn-static -> $ZPFX/bin/nnn" pick"$ZPFX/bin/nnn" bpick"*static*"; zinit load jarun/nnn

# load omz libraries
zinit snippet OMZ::lib/git.zsh

# load omz plugins
zinit snippet OMZ::plugins/autojump/autojump.plugin.zsh
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit snippet OMZ::plugins/vscode/vscode.plugin.zsh

# load omz completions
zinit ice as"completion"; zinit snippet OMZ::plugins/docker/_docker
zinit ice as"completion"; zinit snippet OMZ::plugins/vagrant/_vagrant

# load normal github plugin with theme depending on omz git library
zinit ice depth=1; zinit light romkatv/powerlevel10k

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
