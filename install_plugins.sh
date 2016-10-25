#!/bin/bash
VIM_DIR=$HOME/vimfiles/
if [ "$1" == "-l" ]; then
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

function check_file_exists {
    echo "Checking to see if "$1"file is present."
    if [ ! -f $1 ]; then
        echo "File was missing"
        return 1
    else
        echo "File present"
        return 0
    fi
}

function check_dir_exists {
    echo "Checking to see if "$1"directory is present."
    if [ ! -d $1 ]; then
        echo "Directory was missing"
        return 1
    else
        echo "Directory present"
        return 0
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

function check_ctrlp {
    CTRLP_DIR=$BUNDLE_DIR"ctrlp.vim/"
    CTRLP_GIT="https://github.com/ctrlpvim/ctrlp.vim.git"

    echo "CtrlP Plugin: "

    check_dir_exists $CTRLP_PATH
    if [ "$?" -eq 1 ]; then
        echo "Downloading CtrlP Plugin"
        git clone $CTRLP_GIT $CTRLP_PATH
    else
        echo "CtrlP present"
    fi
}

echo $LINE
create_dir_if_absent $VIM_DIR
echo $LINE
create_dir_if_absent $AUTOLOAD_DIR
echo $LINE

#Checking if pathogen vim plugin is present
check_pathogen
echo $LINE
check_ctrlp
echo $LINE

