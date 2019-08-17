" disable menubar
set guioptions-=m
" disable toolbar
set guioptions-=T
" disable scrollbar
set guioptions-=r
" always show statusbar
set laststatus=2
" show the cursor position all the time
set ruler

set encoding=utf-8
set fileencoding=utf-8
" no compatibility with Vi
set nocompatible
" highlighting and syntax colours enabled
" syntax enable
" filetype detection on + plugin loading on
" filetype plugin on
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" allow F3 to insert a datetime stamp
imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

" define MakeTags command to create language tags (file) for tag based
" navigation and autocompletion
command! MakeTags !ctags -R .

" disable netrw
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
" File browsing
" let g:netrw_banner=0		" disable banner
" let g:netrw_browse_split=4	" open in prior window
" let g:netrw_altv=1		" open splits to the right
" let g:netrw_liststyle=3		" tree view
" let g:netrw_winsize=25		" width of netrw window (%)
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+' " hide dot files, unnecessary
" for now...
"
" enable fold level 1 for shell files
let g:sh_fold_enabled= 1

" store backup, undo, and swap files in special directory
set directory=$HOME/Dropbox/Notes/_vim/_swp//
set backupdir=$HOME/Dropbox/Notes/_vim/_backup//
set undodir=$HOME/Dropbox/Notes/_vim/_undo//

" remap open file in split window to vertical version
nnoremap <C-W><C-F> <C-W>vgf

" set max width of document
set textwidth=0

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

filetype off                  " required
set rtp+=~\vimfiles\bundle\Vundle.vim
call vundle#begin('~\vimfiles\bundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'irrationalistic/vim-tasks'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'justinmk/vim-dirvish'
call vundle#end()            " required
filetype plugin indent on    " required
syntax enable

" allow project specific vimrc configuration
set exrc 

" disable unsecure commands in project specific vimrc files
set secure

" miscellaneous stuff
" Set shell to bash instead of cmd
" set shell=C:\Users\Eigenaar\Downloads\Computer\ stuff\Git-2.18.0-64-bit\git-bash.exe

" omnisharp configuration
" automatically highlight types
let g:OmniSharp_highlight_types = 2

" Set the type lookup function to use the preview window instead of echoing it
" let g:OmniSharp_typeLookupInPreview = 1
let g:OmniSharp_server_stdio = 1

" start omnisharp-vim manually
" let g:OmniSharp_start_server = 0
" let g:OmniSharp_port = 2000

" let g:OmniSharp_proc_debug = 1
" let g:OmniSharp_loglevel = 'debug'

" Trigger configuration for UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" let :UltiSnipsEdit split window vertically
let g:UltiSnipsEditSplit="vertical"

