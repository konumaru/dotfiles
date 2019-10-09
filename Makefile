
DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
OS := $(shell uname | tr '[A-Z]' '[a-z]')
CANDIDATES := $(wildcard .??*)
SCRIPT := $(DOTPATH)/etc/init/$(OS)/init.sh
EXCLUSIONS := .DS_Store .git
DOTFILES := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

init:
	@echo 'Start to init'
	@DOTPATH=$(DOTPATH) bash $(SCRIPT)

deploy:
	@echo 'Start to deploy'
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	# @$(ln -sfnv $(DOTPATH)/settings.json ~/Library/Application\ Support/Code/User/settings.json)

# clean:
# 	@echo 'Start to clean'
# 	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
# 	-rm -rf $(DOTPATH)

# update:
# 	@echo 'Start to update'
# 	@git pull origin master
# 	@make deploy
