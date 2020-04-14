# 色を使用できるようにする
autoload -Uz colors
colors

# zsh syntax highlight
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh autosuggestion from history.
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*' list-colors "${LS_COLORS}"
## タブ補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ls補完時、backgroudでhightlight
zstyle ':completion:*' menu select

# Themaをpureに設定
autoload -Uz promptinit
promptinit
prompt pure

# alias
alias cdd='cd /Users/rui/Documents'
alias cdr='cd /Users/rui/Repro'

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH

# rbenv
export PATH="~/.rbenv/shims:/usr/local/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="/usr/local/var/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

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
# 同時に起動しているzshの間でhistoryを共有する
setopt share_history
# コマンドのスペルミスを指摘
setopt correct
# ビープ音を鳴らさない
setopt no_beep
 # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# 語の途中でもカーソル位置で補完
setopt complete_in_word
#入力途中の履歴補完を有効化する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
# エイリアスコマンドのハイライト
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
# 存在するパスのハイライト
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# グロブ
ZSH_HIGHLIGHT_STYLES[globbing]='none'

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


fpath+=~/.zfunc

# zsh completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    autoload -Uz compinit
    compinit
fi
