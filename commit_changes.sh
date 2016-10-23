#!/bin/bash
echo "Copying over local .vimrc into repo and commiting with commit message:" 
echo $1

cp ~/.vimrc .
git add .vimrc
git commit -m "$1"
