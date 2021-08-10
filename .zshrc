autoload -Uz promptinit compinit;
promptinit;
compinit;
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk


# Zinit plugins
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
zinit light 'b4b4r07/enhancd'
zinit load 'junegunn/fzf-bin'
zinit load 'zdharma/history-search-multi-word'
## Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure


# alias
alias cdd='cd /Users/rui/Documents'
# alias cdr='cd /Users/rui/Repro'
alias ls='ls -al'


# Environment variables
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH

## ruby
### rbenv
export PATH="~/.rbenv/shims:/usr/local/bin:$PATH"
eval "$(rbenv init -)"
### gem
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

## python
### pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
### poetry
export PATH="$HOME/.poetry/bin:$PATH"

## javascript
### nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

## GCP
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

export GOOGLE_APPLICATION_CREDENTIALS=~/.ssh/repro-lab-9cbbf157d212.json
export GCP_CREDENTIAL=/Users/rui/.ssh/repro-lab-9cbbf157d212.json

function gconf() {
  projData=$(gcloud config configurations list | peco)
  if echo "${projData}" | grep -E "^[a-zA-Z].*" > /dev/null ; then
    config=$(echo ${projData} | awk '{print $1}')
    gcloud config configurations activate ${config}

    echo "=== The current account is as follows ==="
    gcloud config configurations list | grep "${config}"
  fi
}

## kaggle
export KAGGLE_CONFIG_DIR="$HOME/.kaggle"

## zsh
export HISTSIZE=1000
export SAVEHIST=100000
### ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
### スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
### 余分な空白は詰めて記録
setopt hist_reduce_blanks
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
### 部分補完をしてくれるやつ
setopt list_types
setopt auto_list
setopt auto_menu
setopt complete_in_word
### 入力途中の履歴補完を有効化する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
