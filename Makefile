EXCLUSIONS := .DS_Store .git .github .gitmodules .config
CANDIDATES := $(wildcard .??*) $(wildcard .config/??*) # bin
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

TODAY      := ${shell date '+%Y_%m_%d'}

default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done


deploy: ## Create symlink to home directory
	mkdir -p ${HOME}/.config
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)


list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)


clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)


backup:
	# Upload to github
	git add -A
	git commit -m "[backup] ${TODAY}"
	git push origin main


gen-github-sshkey:
	sh ./etc/set_github_ssh_key.sh

dump-dconf: ## Dump ubuntu conf
	dconf dump / > $(PWD)/backups/ubuntu-20.04/full-backup
	guake --save-preferences $(PWD)/backups/ubuntu-20.04/my-guake-preferences

load-dconf:
	dconf load $(PWD)/backups/ubuntu-20.04/ < /
	guake --restore-preferences $(PWD)/backups/ubuntu-20.04/my-guake-preferences

dump-brewfile:
	brew bundle dump --force --file ${HOME}/.dotfiles/backups/macos/Brewfile
