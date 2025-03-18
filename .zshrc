USERNAME=$(whoami)

IS_MAC=false
IS_WSL=false

case ${OSTYPE} in
  darwin*)
    IS_MAC=true
    ;;
  linux*)
    IS_WSL=true
    ;;
esac

### Added by Zinit's installer
if [[ ! -e $HOME/.local/share/zinit/zinit.git ]]; then
    echo "install zinit"
    sh -c "$(curl -fsSL https://git.io/zinit-install)"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Zinit plugins
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
zinit snippet 'OMZ::plugins/git/git.plugin.zsh'
zinit snippet 'OMZ::lib/clipboard.zsh'
zinit snippet 'OMZ::lib/completion.zsh'
zinit snippet 'OMZ::lib/compfix.zsh'
zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zinit light 'zsh-users/zsh-autosuggestions'
zinit light 'zsh-users/zsh-completions'
zinit light 'zdharma/fast-syntax-highlighting'
zinit light 'chrissicool/zsh-256color'
zinit light 'paulirish/git-open'
zinit light 'reegnz/jq-zsh-plugin'
zinit light 'b4b4r07/emoji-cli'
zinit light 'mollifier/anyframe'
zinit light 'reegnz/jq-zsh-plugin'
zinit load 'junegunn/fzf-bin'
## Load pure theme
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

## Zstyle
zmodload zsh/nearcolor
zstyle :prompt:pure:path color '#6495ed'
autoload -U promptinit; promptinit
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## zsh
export HISTSIZE=1000
export SAVEHIST=100000
### ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
### スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space ### 余分な空白は詰めて記録 setopt hist_reduce_blanks
### historyコマンドは履歴に登録しない
setopt hist_no_store
### 同時に起動しているzshの間でhistoryを共有する
setopt share_history
### コマンドのスペルミスを指摘
setopt correct
### ビープ音を鳴らさない
setopt no_beep
### ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
### 語の途中でもカーソル位置で補完
setopt complete_in_word
### history の共有
setopt share_history
### 部分補完をしてくれるやつ
setopt list_types
setopt auto_list
setopt auto_menu
setopt complete_in_word
### 入力途中の履歴補完を有効化する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Environment variables
export PATH="/Users/${USERNAME}/.local/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH
export XDG_CONFIG_HOME="$HOME/dotfiles/.config"

## homebrew
case ${OSTYPE} in
  darwin*)
    eval $(/opt/homebrew/bin/brew shellenv)
    ;;
  linux*)
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\""
    ;;
esac

# alias
alias reload='source ~/.zshrc'
alias cdd='cd ${HOME}/Documents'
alias cdr='cd ${HOME}/Documents/repository'
alias ls='ls -alh'
alias vim='nvim'
alias python='python3'
alias cc-kaggle='cookiecutter gh:konumaru/cookiecutter-kaggle'
alias gr='cd $(ghq list -p | fzf)'
alias plzip='curl ifconfig.me'


# direnv
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi
# github cli
if command -v gh &> /dev/null; then
    eval "$(gh completion -s zsh)"
fi

## kaggle
export KAGGLE_CONFIG_DIR="$HOME/.kaggle"

## nodejs, npm with nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# gconf.zsh
function gconf() {
  projData=$(gcloud config configurations list | peco)
  if echo "${projData}" | grep -E "^[a-zA-Z].*" > /dev/null ; then
    config=$(echo ${projData} | awk '{print $1}')
    gcloud config configurations activate ${config}

    echo "=== The current account is as follows ==="
    gcloud config configurations list | grep "${config}"
  fi
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then 
. "$HOME/google-cloud-sdk/path.zsh.inc"; 
fi
