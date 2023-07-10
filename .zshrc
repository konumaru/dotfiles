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

## Zstyle
zmodload zsh/nearcolor
zstyle :prompt:pure:path color '#6495ed'
autoload -U promptinit; promptinit
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

USERNAME=$(whoami)

# Env variables
export PATH="/Users/${USERNAME}/.local/bin:$PATH"

# alias
alias reload='source ~/.zshrc && tmux source-file ~/.tmux.conf'
alias cdd='cd ${HOME}/Documents'
alias cdn='cd ${HOME}/Documents/works/note'
alias ls='ls -alh'
alias vim='nvim'
alias cc-kaggle='cookiecutter gh:konumaru/cookiecutter-kaggle'

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
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH
export XDG_CONFIG_HOME="$HOME/.dotfiles/.config"

## nodejs, npm with nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
### End of Zinit's installer chunk

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"

## poetry
export PATH="$HOME/.local/bin:$PATH"

## kaggle
export KAGGLE_CONFIG_DIR="$HOME/.kaggle"

## homebrew
case ${OSTYPE} in
  darwin*)
    ARCH=$(uname -m)
    if [[ $ARCH == arm64 ]]; then
        eval $(/opt/homebrew/bin/brew shellenv)
    elif [[ $ARCH == x86_64 ]]; then 
        eval $(/usr/local/bin/brew shellenv)
    fi
    ;;
  linux*)
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\""
    ;;
esac

## direnv
eval "$(direnv hook zsh)"

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
### End of Zinit's installer chunk
