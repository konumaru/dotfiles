# Environment variables
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH

## ruby
### rbenv
export PATH="~/.rbenv/shims:/usr/local/bin:$PATH"
### gem
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

## python
### pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
### poetry
export PATH="$HOME/.poetry/bin:$PATH"

## javascript
### nodenv
export PATH="$HOME/.nodenv/bin:$PATH"

## GCP
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

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

## Neovim
export XDG_CONFIG_HOME="$HOME/.config"
