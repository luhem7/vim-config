#!/bin/bash
VIM_DIR=$HOME/vimfiles/
if [ "$1" = "-l" ]; then
    echo "Using linux vim files directory"
    VIM_DIR=$HOME/.vim/
fi

AUTOLOAD_DIR=$VIM_DIR"autoload/"
BUNDLE_DIR=$VIM_DIR"bundle/"
PATHOGEN_LOC=$AUTOLOAD_DIR"pathogen.vim"

LINE="--------------------------"

function create_dir_if_absent {
    echo "Checking if "$1" directory is present."
    if [ ! -d $1 ]; then
        echo $1" directory missing, creating it."
        mkdir $1
    else
        echo $1" directory is present"
    fi
}

function check_pathogen {
    PATHOGEN_DL="https://tpo.pe/pathogen.vim"
    echo "Checking to see if pathogen vim file is present."
    if [ ! -f $PATHOGEN_LOC ]; then
        echo "Pathogen missing, downloading from "$PATHOGEN_DL
        curl -LSso $PATHOGEN_LOC $PATHOGEN_DL
    else
        echo "Pathogen vim file present"
    fi

   create_dir_if_absent $BUNDLE_DIR
}

echo $LINE
create_dir_if_absent $VIM_DIR
echo $LINE
create_dir_if_absent $AUTOLOAD_DIR
echo $LINE

#Checking if pathogen vim plugin is present
check_pathogen
echo $LINE

