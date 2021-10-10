export PATH=$PATH:"/usr/bin/"

# Environment variables
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH

## python
### pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
### poetry
export PATH="$HOME/.poetry/bin:$PATH"

## kaggle
export KAGGLE_CONFIG_DIR="$HOME/.kaggle"

## Neovim
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
