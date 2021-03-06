"<-------------------- OPTIONS -------------------->

set pythonthreedll=python37.dll                                 " set python dll path
if has('python3')                                               " circumvent bug in vim where imp is deprecated in favor of importlib see <https://github.com/vim/vim/issues/3117>
  silent! python3 1
endif

set number                                                      " Set line numbers to always show
set relativenumber                                              " Use relative line numbers
set textwidth=0                                                 " set max width of document
set laststatus=2                                                " Set status bar to always show
set guioptions-=m                                               " Disable menu bar
set guioptions-=T                                               " Disable toolbar
set guioptions-=r                                               " Disable righthand scrollbar
set guioptions-=L                                               " Disable lefthand scrollbar
set ruler                                                       " Show the cursor position all the time
set showcmd							" display incomplete commands
set noshowmode							" hides the displaying of currently active mode

set langmenu=en_US.UTF-8                                        " Set menu language to english and language (used during error messages 
language en_US                                                  " etc..?? to english)
set encoding=utf-8
set fileencoding=utf-8
set nocompatible                                                " no compatibility with Vi

set path+=**                                                    " Search down into subfolders
                                                                " Provides tab-completion for all file-related tasks

set wildmenu                                                    " Display all matching files when we tab complete

set rtp+=~/.vim/bundle/Vundle.vim                               
set rtp+=$HOME/mysnippets
set directory=$HOME/Dropbox/Notes/_vim/_swp//                   " store backup, undo, and swap files in special directory
set backupdir=$HOME/Dropbox/Notes/_vim/_backup//
set undodir=$HOME/Dropbox/Notes/_vim/_undo//

set exrc                                                        " allow project specific vimrc configuration

set secure                                                      " disable unsecure commands in project specific vimrc files

"set sessionoptions-=options                                     " remove certain options from being saved when using mksession command for plugin compatibility reasons

"set shell=\"$PROGRAMW6432\Git\bin\bash.exe\"			" set :term terminal to bash instead of cmd.exe
								" this currently breaks :!{cmd} and :PluginInstall from Vundle
								" see <https://github.com/vim/vim/issues/4950>

set undofile							" enable persistent undo
set backup							" ensure that older backup files are automatically deleted

"<-------------------- END OPTIONS -------------------->

"<-------------------- VARIABLES -------------------->

"<<-------------------- VIM -------------------->>

let mapleader="\\"
let maplocalleader="\<space>"
let g:sh_fold_enabled= 1                                        " enable fold level 1 for shell files

"<<-------------------- END VIM -------------------->>

" <<-------------------- CALENDAR -------------------->>

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" <<-------------------- END CALENDAR -------------------->>

" <<-------------------- OMNISHARP-------------------->>

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
" <<-------------------- END OMNISHARP-------------------->>

" <<-------------------- ULTISNIPS -------------------->>

let g:UltiSnipsSnippetsDir="$HOME/mysnippets"					" Ensure UltiSnipsEdit command edits snippets in this custom snippets directory
let g:UltiSnipsSnippetDirectories=[$HOME.'/mysnippets', "UltiSnips"]		" Define directories UltiSnips searches for snippets
let g:UltiSnipsExpandTrigger="<tab>"                            		" Trigger configuration for UltiSnips
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:UltiSnipsEditSplit="vertical"                             		" let :UltiSnipsEdit split window vertically

" <<-------------------- END ULTISNIPS -------------------->>

" <<-------------------- NETRW -------------------->>

let g:loaded_netrwPlugin = 1                                    " disable netrw
" File browsing
" let g:netrw_banner=0                                          " disable banner
" let g:netrw_browse_split=4                                    " open in prior window
" let g:netrw_altv=1                                            " open splits to the right
" let g:netrw_liststyle=3                                       " tree view
" let g:netrw_winsize=25                                        " width of netrw window (%)
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'                " hide dot files, unnecessary

" <<-------------------- END NETRW -------------------->>

" <<-------------------- CTRLP -------------------->>

let g:ctrlp_working_path_mode = 'ra'				" search for a 'root' folder (containing .git,...). If none found, use current directory
								" unless it is a child of 'cwd' (see :lcd).
let g:ctrlp_show_hidden = 1					" enable searching for dotfiles
let g:ctrlp_max_files= 0					" for some reason this is necessary to ensure that all files are found, see: <https://github.com/kien/ctrlp.vim/issues/234>
let g:ctrlp_max_depth = 40					" increase default search depth

" <<-------------------- END CTRLP -------------------->>

"<<-------------------- STARTIFY -------------------->>
"
let g:startify_session_dir = '~/Dropbox/Notes/_vim/_session'

"<<-------------------- END STARTIFY -------------------->>

"<<-------------------- LIGHTLINE -------------------->>

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

"<<-------------------- END LIGHTLINE -------------------->>

"<-------------------- END VARIABLES -------------------->

"<-------------------- FUNCTIONS -------------------->

function! HandleURL()                                           " Since we disable netrw gx will not work any more. Create a function for it
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

"set diffexpr=MyDiff()						" Default diff function
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg1 = substitute(arg1, '!', '\!', 'g')
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg2 = substitute(arg2, '!', '\!', 'g')
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let arg3 = substitute(arg3, '!', '\!', 'g')
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      if empty(&shellxquote)
"        let l:shxq_sav = ''
"        set shellxquote&
"      endif
"      let cmd = '"' . $VIMRUNTIME . '\diff"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  let cmd = substitute(cmd, '!', '\!', 'g')
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
"  if exists('l:shxq_sav')
"    let &shellxquote=l:shxq_sav
"  endif
"endfunction

"<-------------------- END FUNCTIONS -------------------->


"<-------------------- MAPPINGS -------------------->

" remap HandleUrl to gx to replace disabled netrw's gx
nnoremap gx :call HandleURL()<CR>

" allow F3 to insert a datetime stamp
imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

" define MakeTags command to create language tags (file) for tag based
" navigation and autocompletion
command! MakeTags !ctags -R .

" remap Explore, Sexplore, Vexplore since we disabled netrw
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" remap open file in split window to vertical version
nnoremap <C-W><C-F> <C-W>vgf

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Create mapping to easily switch to a file's directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Allow for a convenient way to quickly increase and decrease font size
nnoremap <silent> <C-Up> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ 'g')<CR>
nnoremap <silent> <C-Down> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ 'g')<CR>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
 endif
" If windows/dos, remove CTRL-X mapping to cut text
if has('win32') || has('win64')
	silent! vunmap <C-X>
endif

" Prevent dirvish from overriding - behavior unless in dirvish buffer
map - -

" Add mapping to quickly create diary entry
" TODO: Use environment variable
nnoremap <leader>dn :exec 'edit ~/Dropbox/Notes/Personal/Diary/' . strftime("%Y/%m-%d-%A.md")<CR>

" Add mapping to quickly create new note
" TODO: Use environment variable
command! -nargs=1 NewZettel :exec ':e ~/Dropbox/Zettelkasten/' . strftime("%Y%m%dT%H%M%S%z") . "-<args>.md"
nnoremap <leader>zn :NewZettel 

" Add mapping to quickly change directory to your zettelkasten
nnoremap <leader>zz :cd ~/Dropbox/Zettelkasten<CR>

" Add mapping to quickly search your zettelkasten
" TODO: Use environment variable
command! -nargs=1 SearchZettel vimgrep "<args>" ~/Dropbox/Zettelkasten/**/*.md
nnoremap <leader>zs :SearchZettel 

"<-------------------- END MAPPINGS -------------------->

"<-------------------- AUTOCOMMANDS -------------------->

"<<-------------------- VIM -------------------->>

" automatically create any missing directories when saving a file
augroup vimrc
	autocmd!
	au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
augroup END

"<<-------------------- END VIM -------------------->>

"<<-------------------- DIRVISH -------------------->>

"augroup dirvish_config
"  autocmd!
"  autocmd FileType dirvish silent! unmap -
"augroup END

"<<-------------------- END DIRVISH -------------------->>

"<-------------------- END AUTOCOMMANDS -------------------->

"<-------------------- PACKAGES? -------------------->

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

"<-------------------- END PACKAGES -------------------->

"<-------------------- PLUGINS -------------------->

" consider using vim-plug instead because of issues with non-posix shells

filetype off                  			" required
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' 			" let Vundle manage Vundle, required
Plugin 'altercation/vim-colors-solarized'
Plugin 'CrispyDrone/vim-tasks'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'justinmk/vim-dirvish'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'aquach/vim-http-client'
Plugin 'itchyny/calendar.vim'
Plugin 'tpope/vim-surround'
Plugin 'mhinz/vim-startify'
Plugin 'itchyny/lightline.vim'
call vundle#end()            			" required
filetype plugin indent on 			" filetype detection on + plugin loading on + indentation on (?)
syntax enable 					" highlighting and syntax colours enabled

"<-------------------- END PLUGINS -------------------->
