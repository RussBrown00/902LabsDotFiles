call plug#begin('~/.config/nvim/plugged')
  " Look and Feel
  Plug 'larsbs/vimterial_dark'
  Plug 'airblade/vim-gitgutter'
  Plug 'itchyny/lightline.vim'

  " Functionality
  Plug 'tpope/vim-git'
  Plug 'scrooloose/nerdtree'
  Plug 'godlygeek/tabular'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'davidosomething/vim-enhanced-resolver', { 'do': 'npm install --global enhanced-resolve-cli' }
  Plug 'w0rp/ale'

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
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'

  " post install (yarn install | npm install) then load plugin only for editing supported files
  Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

  " Sortinh
  Plug 'JPricey/vim-order-css'

  Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
call plug#end()


source $HOME/.config/nvim/nvim_settings
source $HOME/.config/nvim/nvim_plugins
source $HOME/.config/nvim/nvim_functions
source $HOME/.config/nvim/nvim_commands
source $HOME/.config/nvim/nvim_mappings
source $HOME/.config/nvim/nvim_autocmds

" Load local .vimrc file
set exrc
