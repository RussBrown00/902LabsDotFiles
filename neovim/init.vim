call plug#begin('~/.config/nvim/plugged')
  " Look and Feel
  " Plug 'morhetz/gruvbox'
  Plug 'larsbs/vimterial_dark'
  Plug 'airblade/vim-gitgutter'
  Plug 'itchyny/lightline.vim'


  " Functionality
  Plug 'tpope/vim-pathogen'
  Plug 'tpope/vim-git'
  Plug 'tsaleh/vim-align'
  Plug 'scrooloose/nerdtree'
  Plug 'godlygeek/tabular'
  Plug 'ervandew/supertab'
  Plug 'scrooloose/syntastic'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'davidosomething/vim-enhanced-resolver', { 'do': 'npm install --global enhanced-resolve-cli' }


  " Multiline editing
  Plug 'terryma/vim-multiple-cursors'


  " Language / formating
  Plug 'sheerun/vim-polyglot'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'jparise/vim-graphql'
  Plug 'vim-scripts/tComment'
  Plug 'kana/vim-textobj-user'
  Plug 'sjl/gundo.vim'
  Plug 'danro/rename.vim'
  Plug 'moll/vim-node'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'w0rp/ale'

  " post install (yarn install | npm install) then load plugin only for editing supported files
  Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

  " Sortinh
  Plug 'JPricey/vim-order-css'


  " Auto complete
  " Plug 'Valloric/YouCompleteMe'
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'tpope/vim-endwise'
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
call plug#end()


source $HOME/.config/nvim/nvim_settings
source $HOME/.config/nvim/nvim_plugins
source $HOME/.config/nvim/nvim_functions
source $HOME/.config/nvim/nvim_commands
source $HOME/.config/nvim/nvim_mappings
source $HOME/.config/nvim/nvim_autocmds

" Load local .vimrc file
set exrc
