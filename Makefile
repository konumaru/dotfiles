today = ${shell date '+%Y_%m_%d'}

setup:
	bash -c "$$(curl -L https://raw.githubusercontent.com/konumaru/dotfiles/main/bin/setup.sh)"

backup:
	bash -c bin/backup.sh

	git add -A
	git commit -m "[backup] ${today}"
	git push origin main
