" set python dll path
set pythonthreedll=python37.dll
" circumvent bug in vim where imp is deprecated in favor of importlib see <https://github.com/vim/vim/issues/3117>
if has('python3')
  silent! python3 1
endif

" disable netrw
let g:loaded_netrwPlugin = 1
" Since we disable netrw gx will not work any more. Create a function for it
function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;()]*')
  let s:uri = shellescape(s:uri, 1)
    echom s:uri
    if s:uri != ""
      silent exec "!start " . s:uri
      :redraw!
    else
      echo "No URI found in line."
    endif
endfunction

nnoremap gx :call HandleURL()<CR>

" Set status bar to always show
set laststatus=2
" Disable menu bar
set guioptions-=m
" Disable toolbar
set guioptions-=T
" Disable scrollbar
set guioptions-=r
" Show the cursor position all the time
set ruler
" Set menu language to english and language (used during error messages
" etc..?? to english)
set langmenu=en_US.UTF-8
language en

set encoding=utf-8
set fileencoding=utf-8
" no compatibility with Vi
set nocompatible
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
set rtp+=~\.vim\bundle\Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'irrationalistic/vim-tasks'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'justinmk/vim-dirvish'
Plugin 'ctrlpvim/ctrlp.vim'
call vundle#end()            " required
" filetype detection on + plugin loading on + indentation on (?)
filetype plugin indent on    " required
" highlighting and syntax colours enabled
syntax enable
" disable saving of options (= ? ) when using mksession for compatibility with
" specific plugins
set sessionoptions-=options

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

