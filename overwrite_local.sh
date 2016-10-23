echo "Backing up local vimrc at ~/.vimrc.bkp"
cp ~/.vimrc ~/.vimrc.bkp
echo "Overwriting local .vimrc with the one from the repo."
cp ./.vimrc ~/.vimrc
