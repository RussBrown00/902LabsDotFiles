call plug#begin('~/.config/nvim/plugged')
  " Look and Feel
  Plug 'airblade/vim-gitgutter'
  Plug 'sonph/onehalf', {'rtp': 'vim/'}
  Plug 'gcmt/taboo.vim'

  " Multiline editing
  " Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Polyglot Language Formatting
  " let g:polyglot_disabled = ['markdown']
  " Plug 'gabrielelana/vim-markdown'
  Plug 'sheerun/vim-polyglot'

  " Language / formating
  Plug 'axelf4/vim-strip-trailing-whitespace'
  Plug 'sbdchd/neoformat'
  Plug 'ambv/black'
  Plug 'csscomb/vim-csscomb'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'jparise/vim-graphql'
  Plug 'vim-scripts/tComment'
  Plug 'danro/rename.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'gabrielelana/vim-markdown'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'davidhalter/jedi-vim'

  " post install (yarn install | npm install) then load plugin only for editing supported files
  Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'tsx', 'css', 'less', 'scss', 'json', 'py', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'mdx'] }

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

  " COC
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-eslint'
  Plug 'neoclide/coc-jest'
  Plug 'neoclide/coc-json'
  Plug 'neoclide/coc-python'
  Plug 'neoclide/coc-tabnine'
  Plug 'neoclide/coc-tslint'
  Plug 'neoclide/coc-yaml'
  Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
  " Plug 'neoclide/coc-tsserver'
  
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

source $HOME/.config/nvim/nvim_theme

" Load local .vimrc file
set exrc
