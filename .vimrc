set nocompatible

" Load plugins for filetype
filetype plugin on

" Set indent for filetype
filetype indent on

" Use local .vimrc file per project to override any settings
set exrc

set backspace=2 " make backspace work like most other apps

" Show airline bar all the time
set laststatus=2

"
" 
execute pathogen#infect()

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:molokai_original = 1

colorscheme molokai

" Configure vim-gitgutter
set updatetime=250
let g:gitgutter_realtime = 750


" NERDTree settings
map <C-n> :NERDTreeToggle<CR>

" Start maximized
au GUIEnter * simalt ~x

" Use CUA keystrokes for clipboard: CTRL-X, CTRL-C, CTRL-V and CTRL-z
" source $VIMRUNTIME/mswin.vim

syntax on
"filetype on
filetype off

" Vundle configuration
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Required for snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

Plugin 'bling/vim-airline'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'

Plugin 'tomasr/molokai'
Plugin 'tpope/vim-fugitive'

Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'

Plugin 'szw/vim-tags'
Plugin 'tomtom/tcomment_vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'ecomba/vim-ruby-refactoring'

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'

Plugin 'scrooloose/syntastic'

Plugin 'majutsushi/tagbar'

" " All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

" General options
set incsearch
set ignorecase smartcase 
set nu

" Use two space tabs
set tabstop=2
set shiftwidth=2
set expandtab

" Setup 80 column word wrap
set wrap 
set linebreak 
set textwidth=80

" No menus and no toolbar
set guioptions-=m  
set guioptions-=T

" Consolas 15 point, ansi character set 
set guifont=Consolas:h13:cANSI

let mapleader = ","
" noremap <leader>t :tabnew<CR>
"
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

map <Leader>f :NERDTreeFind<CR>

" Quickfix open and close
map <Leader>co :copen<CR>
map <Leader>cl :cclose<CR>

let g:rspec_command = '!spring rspec {spec}'
"let ruby_fold=1

" Set Git diff commands to always use vertical split
set diffopt+=vertical

" Add command to search for occurrance of pattern in buffers
function! BuffersList()
  let all = range(0, bufnr('$'))
  let res = []
  for b in all
    if buflisted(b)
      call add(res, bufname(b))
    endif
  endfor
  return res
endfunction

function! GrepBuffers (expression)
  let curbuf = bufnr('%')
  exec 'vimgrep/'.a:expression.'/ '.join(BuffersList())
  exec 'buffer '.curbuf
  exec 'syntax on'
  exec 'copen'
endfunction

command! -nargs=1 Grepproject noautocmd vimgrep /<args>/gj **/*.rb **/*.js **/*.html.erb **/*.js.erb **/*.less |copen
command! -nargs=1 Grepbuffer call GrepBuffers(<q-args>)
nnoremap <leader>z :call GrepBuffers("<C-R><C-W>")<CR> :cw<CR>

" Turn on folding for ruby files but open all folds
autocmd Syntax ruby setlocal foldmethod=syntax
autocmd Syntax ruby normal zR

" Set foldmethod to indent for eruby (erb template) files
autocmd Syntax eruby setlocal foldmethod=indent
autocmd Syntax eruby normal zR

" Set nowrap for eruby files
autocmd Syntax eruby setlocal nowrap

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" More logical split commands
" Easier navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tagbar toggle
map <Leader>tt :TagbarToggle<CR>

