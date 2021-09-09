today = ${shell date '+%Y_%m_%d'}

setup:
	bash -c "$$(curl -L https://raw.githubusercontent.com/konumaru/dotfiles/main/bin/setup.sh)"

backup:
	bash -c bin/backup.sh
	# Upload to github
	git add -A
	git commit -m "[backup] ${today}"
	git push origin main

test:
	echo "Hello"

setup-win:
	New-Item -Path 'C:\Users\konum\Documents\repositories\dotfiles' -Value 'C:\Users\konum\Documents\repositories\dotfiles\profile.ps1' -Name 'C:\Users\konum\Documents\repositories\dotfiles\profile.ps1.symlink' -ItemType SymbolicLink
