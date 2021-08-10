# Env variables
SCRIPT_DIR=$(cd $(dirname $0); pwd)

sh ${SCRIPT_DIR}/brew_setup.sh


# @$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

# dotfiles=(".zshrc")
# for f in $dotfiles
# do
#     ln -sfnv ${SCRIPT_DIR}/${f} $HOME/${f}
# done
