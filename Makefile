setup:
	bash -c "$(curl -L https://raw.githubusercontent.com/konumaru/dotfiles/main/bin/install.sh)"

backup:
	brew bundle dump --force --file Brewfile
