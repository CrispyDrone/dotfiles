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
" File browsing
" let g:netrw_banner=0		" disable banner
" let g:netrw_browse_split=4	" open in prior window
" let g:netrw_altv=1		" open splits to the right
" let g:netrw_liststyle=3		" tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+' " hide dot files, unnecessary
" for now...
" remap C-W C-F from editing file under cursor in split window to vertical
" split window
nnoremap <C-W><C-F> <C-W>vgf
" set textwidth to 0 i.e. max
set textwidth=0

filetype off		     " required
set rtp+=~\.vim\bundle\Vundle.vim
call vundle#begin('~\.vim\bundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'irrationalistic/vim-tasks'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'justinmk/vim-dirvish'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ctrlpvim/ctrlp.vim'
call vundle#end()            " required
" filetype detection on + plugin loading on + indentation on (?)
filetype plugin indent on    " required
" highlighting and syntax colours enabled
syntax enable
" disable saving of options (= ? ) when using mksession for compatibility with
" specific plugins
set sessionoptions-=options
" enable file position in status bar
set ruler
