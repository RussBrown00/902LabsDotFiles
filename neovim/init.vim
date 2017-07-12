" Loads pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim

" Pathogen set up
filetype off
call pathogen#infect()
call pathogen#infect('unpublished/{}')
call pathogen#helptags()
filetype plugin indent on

source $HOME/.config/nvim/vimrc_settings
source $HOME/.config/nvim/vimrc_functions
source $HOME/.config/nvim/vimrc_commands
source $HOME/.config/nvim/vimrc_mappings
source $HOME/.config/nvim/vimrc_autocmds

if &loadplugins
  source $HOME/.config/nvim/vimrc_plugins
endif

if filereadable(".vimrc_proj")
    so .vimrc_proj
else
    if filereadable("../.vimrc_proj")
        so .vimrc_proj
    endif
endif
