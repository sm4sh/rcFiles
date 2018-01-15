syntax enable

set backspace=indent,eol,start
let mapleader = ','
set number

"------------------Searching------------------"
set hlsearch
set incsearch

"------------------Mappings------------------"
"Make it easy to edit the Vimrc file."
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Add simple highlight removal - Leader, Leertaste"
nmap <Leader><space> :nohlsearch<cr>

"Einfaches Modus switchen - jj"
imap jj <Esc>

"Char am Ende der Zeile einfügen - öö"
imap <silent>öö <Esc>v`^me<Esc>gi<C-o>:call Ender()<CR>
function! Ender()
  let endchar = nr2char(getchar())
  execute "normal \<End>a".endchar
  normal `e
endfunction

"Suche ignoriert Groß/Kleinschreibung"
:set ignorecase

"Cursor Mode Change bei verschiedenen Modi"
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

"------------------Auto-Commands-------------"
"Automatically source the Vimrc file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END
