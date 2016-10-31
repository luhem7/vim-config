"This file contains the final steps that plugins require you to run from within vim.
"
"This file needs to be SOURCED ONLY ONCE
"
"File can be sourced if you have the file open in vim as so: so %

"TODO This file is oriented towards working on windows machine, need to make it universal
"TODO Use the vim command line options like vim -u NONE -c VIM_COMMANDS_HERE to somemhow make
"the contents of this file run automatically instead of needing someone to run this file

helptags ~/vimfiles/bundle/ctrlp.vim/doc
helptags ~/vimfiles/bundle/vim-fugitive/doc
helptags ~/vimfiles/bundle/vim-eunuch/doc
