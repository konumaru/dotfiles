EXCLUSIONS := .DS_Store .git .github .gitmodules
CANDIDATES := $(wildcard .??*) # bin
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

TODAY      := ${shell date '+%Y_%m_%d'}

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	echo "Init"

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

backup:
	# Upload to github
	git add -A
	git commit -m "[backup] ${TODAY}"
	git push origin main