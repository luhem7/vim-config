#!/bin/bash
VIM_DIR=$HOME/vimfiles/
if [ "$1" == "-l" ]; then
    echo "Using linux vim files directory"
    VIM_DIR=$HOME/.vim/
fi

AUTOLOAD_DIR=$VIM_DIR"autoload/"
BUNDLE_DIR=$VIM_DIR"bundle/"

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
    echo "Checking to see if "$1" directory is present."
    if [ ! -d $1 ]; then
        echo "Directory was missing"
        return 1
    else
        echo "Directory present"
        return 0
    fi
}

function get_repo_name {
    OIFS=$IFS
    IFS="/" read -a MYARRAY <<< "$1"
    echo ${MYARRAY[1]}
    IFS=$OIFS
}

function check_git_repo {
    # $1 = full repo name; example: ctrlpvim/ctrlp.vim.git
    
    REPO_NAME=$(get_repo_name $1)
    REPO_DIR=$BUNDLE_DIR$REPO_NAME
    REPO_DIR=${REPO_DIR%.git}
    REPO_URL="https://github.com/"$1

    cd $BUNDLE_DIR

    echo "Checking if git repo "$1" is already downloaded"

    check_dir_exists $REPO_DIR 
    if [ "$?" -eq 1 ]; then
        echo "Downloading "$1
        git clone $REPO_URL
    else
        echo $1" present"
    fi

    cd -
}

function check_pathogen {
    PATHOGEN_DL="https://tpo.pe/pathogen.vim"
    PATHOGEN_LOC=$AUTOLOAD_DIR"pathogen.vim"
    echo "Checking to see if pathogen vim file is present."
    if [ ! -f $PATHOGEN_LOC ]; then
        echo "Pathogen missing, downloading from "$PATHOGEN_DL
        curl -LSso $PATHOGEN_LOC $PATHOGEN_DL
    else
        echo "Pathogen vim file present"
    fi

   create_dir_if_absent $BUNDLE_DIR
}

function f_main {
    echo $LINE
    create_dir_if_absent $VIM_DIR
    echo $LINE
    create_dir_if_absent $AUTOLOAD_DIR
    echo $LINE

    #Checking if pathogen vim plugin is present
    check_pathogen
    echo $LINE
    check_git_repo ctrlpvim/ctrlp.vim.git
}

f_main
