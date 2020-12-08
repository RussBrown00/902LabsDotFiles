call plug#begin('~/.config/nvim/plugged')
  " Look and Feel
  Plug 'airblade/vim-gitgutter'
  Plug 'sonph/onehalf', {'rtp': 'vim/'}
  Plug 'gcmt/taboo.vim'

  " Multiline editing
  Plug 'terryma/vim-multiple-cursors'

  " Language / formating
  Plug 'sbdchd/neoformat'
  Plug 'sheerun/vim-polyglot'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'jparise/vim-graphql'
  Plug 'vim-scripts/tComment'
  Plug 'danro/rename.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'gabrielelana/vim-markdown'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

  " post install (yarn install | npm install) then load plugin only for editing supported files
  Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'tsx', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

  " Sorting
  " vim-order needs python support which isn't working for some reason locally
  " Plug 'JPricey/vim-order-css'

  " Functionality
  Plug 'tpope/vim-git'
  Plug 'scrooloose/nerdtree'
  Plug 'godlygeek/tabular'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'davidosomething/vim-enhanced-resolver', { 'do': 'npm install --global enhanced-resolve-cli' }
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'zxqfl/tabnine-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'w0rp/ale'

  " Utils
  Plug 'mtth/scratch.vim'
call plug#end()

" Further configuration settings
source $HOME/.config/nvim/nvim_settings
source $HOME/.config/nvim/nvim_plugins
source $HOME/.config/nvim/nvim_autocmds

" Functions and mappings
source $HOME/.config/nvim/nvim_functions
source $HOME/.config/nvim/nvim_mappings

" Load local .vimrc file
set exrc
