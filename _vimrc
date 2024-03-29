"<-------------------- OPTIONS -------------------->

set pythonthreedll=python39.dll                                 " set python dll path

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
set wildmode=longest:full,full					" On first tab, complete till longest shared string, on second tab, complete next match. 
								" Tab is used to switch modes; use CTRL-N/CTRL-P to navigate matches instead of tab!

set rtp+=~/.vim/
set rtp+=$HOME/mysnippets
set directory=$HOME/Dropbox/_vim/_swp//                         " store backup, undo, and swap files in special directory
set backupdir=$HOME/Dropbox/_vim/_backup//
set undodir=$HOME/Dropbox/_vim/_undo//

set exrc                                                        " allow project specific vimrc configuration

set secure                                                      " disable unsecure commands in project specific vimrc files

"set sessionoptions-=options                                    " remove certain options from being saved when using mksession command for plugin compatibility reasons

set shell=\"$PROGRAMW6432\Git\bin\bash.exe\"

set undofile							" enable persistent undo
set backup							" ensure that older backup files are automatically deleted
set shellslash							" use forward slashes when expanding path names

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
" TODO: What if I decide to work on an older project? I need to reinstall the server every time?
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_highlight_groups = {
\ 'NamespaceName': 'Identifier',
\ 'ClassName': 'Type',
"\ 'StructName': 'Structure',
\ 'StructName': 'DraculaOrange',
\ 'ParameterName': 'DraculaOrange',
\ 'InterfaceName': 'DraculaYellow'
\}

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
let g:startify_session_dir = '~/Dropbox/_vim/_session'

"<<-------------------- END STARTIFY -------------------->>

"<<-------------------- LIGHTLINE -------------------->>

let g:lightline = {
      "\ 'colorscheme': 'solarized',
      \ 'colorscheme': 'dracula',
      "\ 'colorscheme': 'gotham',
      "\ 'colorscheme': 'iceberg',
      \ }

"<<-------------------- END LIGHTLINE -------------------->>

"<-------------------- END VARIABLES -------------------->

"<-------------------- FUNCTIONS -------------------->
function! HandleURL()                                           " Since we disable netrw gx will not work any more. Create a function for it
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;()]*')
  let s:uri = shellescape(s:uri, 1) 				" Shellslash breaks this. Not sure why! It adds single quotes somehow
    if s:uri != ""
      echom s:uri
      exec "! start " . s:uri
      redraw!
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
nnoremap <C-W><C-F> <C-W>v<C-W>rgf

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Create mapping to easily switch to a file's directory
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

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

" Allow _ to explore current directory
map _ <Plug>(dirvish_up)

" Add mapping to quickly create diary entry
nnoremap <leader>dn :exec 'edit $PERSONAL_DIARY/' . strftime("%Y/%m-%d-%A.md")<CR>

" Add mapping to quickly create new note
command! -nargs=1 NewZettel :exec ':e $PERSONAL_ZETTELKASTEN/' . strftime("%Y%m%dT%H%M%S%z") . "-<args>.md"
nnoremap <leader>zn :NewZettel 

" Add mapping to quickly change directory to your zettelkasten
nnoremap <leader>zz :cd $PERSONAL_ZETTELKASTEN<CR>

" Add mapping to quickly search your zettelkasten
command! -nargs=1 SearchZettel vimgrep "<args>" $PERSONAL_ZETTELKASTEN/**/*.md
nnoremap <leader>zs :SearchZettel 

" Omnisharp mappings
nnoremap <F12> :OmniSharpGotoDefinition<CR>

" Start interactive EasyAlign in visual mode
xmap <leader>ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object
nmap <leader>ga <Plug>(EasyAlign)

" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)

"let g:go_debug=['lsp', 'shell-commands']
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

augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
  autocmd FileType dirvish let b:ctrlp_working_path_mode = 'c'
augroup END

"<<-------------------- END DIRVISH -------------------->>

"<<-------------------- LIGHTLINE -------------------->>

augroup lightline
  autocmd!
  autocmd ColorScheme * call s:lightline_update()
augroup END

function! s:lightline_update()
  if !exists('g:loaded_lightline')
    return
  endif
  try
    let g:lightline.colorscheme = substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '') " TODO: ?
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  catch
  endtry
endfunction

"<<-------------------- END LIGHTLINE -------------------->>

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

let g:gitgutter_grep=''
let g:gitgutter_log=1

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'altercation/vim-colors-solarized'
Plug 'CrispyDrone/vim-tasks'
Plug 'OmniSharp/omnisharp-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'justinmk/vim-dirvish'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'aquach/vim-http-client'
Plug 'itchyny/calendar.vim'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/vim-easy-align'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'whatyouhide/vim-gotham'
Plug 'cocopon/iceberg.vim'
Plug 'mhinz/vim-signify'
call plug#end()

filetype plugin indent on
"<-------------------- END PLUGINS -------------------->
"
