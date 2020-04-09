#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

autoload -Uz promptinit
promptinit
prompt pure

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# costom
alias cdd='cd /Users/rui/Documents'
alias cdr='cd /Users/rui/repro'
alias python="python3"

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH

# rbenv
export PATH="~/.rbenv/shims:/usr/local/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# dinghy
DOCKER_HOST=tcp://192.168.99.100:2376
DOCKER_CERT_PATH=/Users/rui/.docker/machine/machines/dinghy
DOCKER_TLS_VERIFY=1
DOCKER_MACHINE_NAME=dinghy

# zsh History
export HISTSIZE=1000
export SAVEHIST=100000
## ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
## スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
## 余分な空白は詰めて記録
setopt hist_reduce_blanks
## historyコマンドは履歴に登録しない
setopt hist_no_store

## direnv
eval "$(direnv hook zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

export GOOGLE_APPLICATION_CREDENTIALS=~/.ssh/repro-lab-9cbbf157d212.json

# For kggleAPI
export KAGGLE_USERNAME=konumaru
export KAGGLE_KEY=99b59b479278d613f6c501861acb2222

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
