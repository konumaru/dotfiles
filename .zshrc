IS_MAC=false
IS_WSL=false
HAS_ZINIT=false

case "${OSTYPE}" in
  darwin*)
    IS_MAC=true
    ;;
  linux*)
    if [[ -n "${WSL_DISTRO_NAME:-}" || -n "${WSL_INTEROP:-}" ]] \
      || grep -qiE '(microsoft|wsl)' /proc/sys/kernel/osrelease 2>/dev/null \
      || grep -qiE '(microsoft|wsl)' /proc/version 2>/dev/null; then
      IS_WSL=true
    fi
    ;;
esac

### Added by Zinit's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -r "${ZINIT_HOME}/zinit.zsh" ]]; then
  echo "install zinit"
  if command -v git >/dev/null 2>&1; then
    mkdir -p "${ZINIT_HOME:h}"
    git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
  else
    echo "git is required to install zinit" >&2
  fi
fi

if [[ -r "${ZINIT_HOME}/zinit.zsh" ]]; then
  HAS_ZINIT=true
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
  # zinit snippet 'OMZ::lib/completion.zsh'
  # zinit snippet 'OMZ::lib/compfix.zsh'
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
  zinit load 'junegunn/fzf-bin'

  ## Load pure theme
  zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
  zinit light sindresorhus/pure
fi

### End of Zinit's installer chunk

## Zstyle
zmodload zsh/nearcolor
zstyle :prompt:pure:path color '#6495ed'
autoload -U promptinit
promptinit

fpath+=("${HOME}/.zfunc")

ZSH_CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"
if ! mkdir -p "${ZSH_CACHE_DIR}" 2>/dev/null; then
  ZSH_CACHE_DIR="${TMPDIR:-/tmp}/${USER:-${LOGNAME:-user}}-zsh"
  mkdir -p "${ZSH_CACHE_DIR}" 2>/dev/null
fi

autoload -Uz compinit
if [[ -d "${ZSH_CACHE_DIR}" && -w "${ZSH_CACHE_DIR}" ]]; then
  compinit -d "${ZSH_CACHE_DIR}/zcompdump"
else
  compinit
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu no

if $HAS_ZINIT; then
  zinit light "Aloxaf/fzf-tab"
fi

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -la -- ${(Q)realpath}'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'ls -la -- ${(Q)realpath}'

## zsh
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS 
setopt hist_ignore_space ### 余分な空白は詰めて記録 setopt hist_reduce_blanks
### historyコマンドは履歴に登録しない
setopt hist_no_store
### 同時に起動しているzshの間でhistoryを共有する
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

# Environment variables
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH
export XDG_CONFIG_HOME="$HOME/dotfiles/.config"
export XDG_RUNTIME_DIR=/tmp

## homebrew
BREW_BIN=""
for candidate in \
  /opt/homebrew/bin/brew \
  /usr/local/bin/brew \
  /home/linuxbrew/.linuxbrew/bin/brew \
  "${HOME}/.linuxbrew/bin/brew"; do
  if [[ -x "${candidate}" ]]; then
    BREW_BIN="${candidate}"
    break
  fi
done

if $IS_MAC; then
  [[ -n "${BREW_BIN}" ]] && eval "$("${BREW_BIN}" shellenv)"
elif $IS_WSL; then
  [[ -n "${BREW_BIN}" ]] && eval "$("${BREW_BIN}" shellenv)"
fi

# alias
alias c='clear'
alias reload='source ~/.zshrc'
alias cdd='cd ${HOME}/Documents'
alias cdr='cd ${HOME}/Documents/repository'
alias ls='ls -alh'
alias vim='nvim'
alias python='python3'
alias pip='pip3'
alias cc-kaggle='cookiecutter gh:konumaru/cookiecutter-kaggle'
alias gr='cd $(ghq list -p | fzf)'
alias lg='lazygit'

# direnv
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi
# github cli
if command -v gh &> /dev/null; then
    eval "$(gh completion -s zsh)"
fi
# uv
if command -v gh &> /dev/null; then
    eval "$(uv generate-shell-completion zsh)"
fi

## cookiecutter
export PATH=$HOME/.local/bin:$PATH
## kaggle
export KAGGLE_CONFIG_DIR="$HOME/.kaggle"

## nodejs, npm with nvm
if $IS_MAC; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
elif $IS_WSL; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"
fi


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

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

# bun completions
[ -s "/home/konumaru/.bun/_bun" ] && source "/home/konumaru/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/konumaru/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
