" Basic settings {{{
  set nocompatible
  scriptencoding utf-8
  set number
  set relativenumber
  set showcmd

  " more powerful backspacing
  " https://stackoverflow.com/a/11560415
  set backspace=indent,eol,start

  set splitright

  syntax on
  set hlsearch
  " Set hlsearch but deactivate it when I source
  nohlsearch
  set incsearch
  set autoread
  " set spell

  filetype on
  filetype plugin on
  filetype indent on
  set smarttab

  " completion
  set omnifunc=syntaxcomplete#Complete

  " set paste
  set pastetoggle=<F2>

  set path+=**
  set wildmenu

  " Adding split buffers to the right
  set splitright

  " Wrap words
  set linebreak

  " Most of the last line instead of lines of @s (for long lines)
  set display+=lastline

  " Use the + register when yanking, see
  " https://stackoverflow.com/a/14188309
  " and the comment by Fritzophrenic here:
  " http://vim.wikia.com/wiki/Accessing_the_system_clipboard
  set clipboard^=unnamedplus

  " no joining of sentences with two spaces
  set nojoinspaces

  " matchit
  " packadd! matchit

  " Preserve clipboard when quitting Vim {{{

  " https://stackoverflow.com/a/45553311
  " autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) .
  "       \ ' | xclip -selection clipboard')

  " https://stackoverflow.com/a/48959734
  if executable("xsel")
    function! PreserveClipboard()
      call system("xsel -ib", getreg('+'))
      " call system('echo ' . shellescape(getreg('+')) . ' | xclip -selection clipboard')
    endfunction
    function! PreserveClipboadAndSuspend()
      call PreserveClipboard()
      suspend
    endfunction
    autocmd VimLeave * call PreserveClipboard()
    nnoremap <silent> <c-z> :call PreserveClipboadAndSuspend()<cr>
    vnoremap <silent> <c-z> :<c-u>call PreserveClipboadAndSuspend()<cr>
  endif
  " }}}

  " Make Ex mode ! commands to zsh interactive
  " (However opening zsh straight in Ex line, hence not adopted)
  " (aliases are recognized)
  " set shellcmdflag=-ic

  " trying to remove weird characters (see :help modifyOtherKeys)
  " https://www.reddit.com/r/vim/comments/gv410k/strange_character_since_last_update_42m/
  " https://github.com/vim/vim/issues/6111
  " let &t_TI = "\<Esc>[>4;2m"
  " let &t_TE = "\<Esc>[>4;m"
  if !has('gui_running') && !has('nvim')
    let &t_TI = ""
    let &t_TE = ""
  endif

" }}}

" Netrw: {{{
  " same-window mode with - (vim-unimpaired)
  " back to file with <c-^>
  " See: http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
  " Also Tim Pope's Vim Vinegar: https://github.com/tpope/vim-vinegar
  let g:netrw_banner=0
  let g:netrw_liststyle=1
  let g:netrw_browse_split=0
  " see helpt netrw-p
  let g:netrw_preview=1
  let g:netrw_winsize=30

  " Hide dot files, toggle with 'gh'
  let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

  " Tree mode, removing banner, toggle with <alt-a> {{{
  " https://shapeshed.com/vim-netrw/
  " For now left aside because of this bug:
  " https://github.com/vim/vim/issues/3276
  " let g:netrw_banner = 0
  " Toggle Netrw with C-a {{{
  " (https://vi.stackexchange.com/questions/10988/toggle-explorer-window/17684#17684)
  " let g:NetrwIsOpen=0

  " " Netrw mapping
  " noremap <silent> <m-a> :call ToggleNetrw()<CR>

  " function! ToggleNetrw()
  "   if g:NetrwIsOpen
  "     let i = bufnr("$")
  "     while (i >= 1)
  "       if (getbufvar(i, "&filetype") == "netrw")
  "         silent exe "bwipeout " . i
  "       endif
  "       let i-=1
  "     endwhile
  "     let g:NetrwIsOpen=0
  "     " Reset netrw to defaults
  "     let g:netrw_liststyle=1
  "     let g:netrw_browse_split=0
  "   else
  "     let g:NetrwIsOpen=1
  "     " Set netrw to drawer style
  "     let g:netrw_liststyle=3
  "     let g:netrw_browse_split=5
  "     let g:netrw_winsize=25
  "     silent Lexplore
  "   endif
  " endfunction
  " " }}}
  " " }}}
" }}}


" Ctags {{{
" https://stackoverflow.com/a/33652614

" set tags+=.tags;$HOME
  nnoremap <leader>ccc :!ctags -R .<CR>
"}}}


" Settings by file types {{{
  augroup silent FileTypeSettings

    autocmd!

    " Vim
    autocmd FileType vim,zsh,sh setlocal
          \ tabstop=2
          \ softtabstop=2
          \ shiftwidth=2
          \ autoindent
          \ nowrap
          \ expandtab |
          \ retab

    " Python
    autocmd FileType python setlocal
          \ tabstop=4
          \ softtabstop=4
          \ shiftwidth=4
          \ expandtab
          \ autoindent
          \ nowrap
          \ textwidth=79
          \ fileformat=unix |
          \ retab

    " Markdown
    autocmd FileType markdown setlocal
          \ tabstop=2
          \ shiftwidth=2
          \ softtabstop=2
          \ wrap
          \ nolist
          \ linebreak
          \ expandtab |
          \ retab

    " Text
    autocmd FileType text setlocal
          \ tabstop=2
          \ shiftwidth=2
          \ softtabstop=2
          \ wrap
          \ nolist
          \ linebreak
          " \ expandtab |
          " \ retab
          " \ textwidth=79
          " \ showbreak= 
                              " nolist required for
                              " linebreak (don't break words)
                              " first char of visual lines set
                              " as an nonbreakable space (not
                              " displayed here but typed:
                              " <c-v> u 202f)

    " LaTex
    autocmd FileType tex setlocal
          \ tabstop=2
          \ softtabstop=2
          \ shiftwidth=2
          \ expandtab
          \ wrap |
          \ retab
          " \ textwidth=79
          " \ iskeyword+=:  " TIP: if you write your \label's as \label{fig:something},
                          " then if you type in \ref{fig: and press <C-n>
                          " you will automatically cycle through all
                          " the figure labels. Very useful! (See Vim LaTeX below)

    " Web &c
    autocmd FileType ruby,javascript,html,htmldjango,css,scss,xml,json setlocal
          \ tabstop=2
          \ shiftwidth=2
          \ softtabstop=2
          \ expandtab
          \ autoindent
          \ nowrap |
          \ retab
          " \ iskeyword+=- |


    " Java, C, C++, Arduino
    autocmd FileType c,cpp,java,arduino setlocal
          \ tabstop=4
          \ softtabstop=4
          \ shiftwidth=4
          \ noexpandtab
          \ autoindent
          \ nowrap
          \ commentstring=//%s

    " Jupyter notebooks
    " https://vi.stackexchange.com/a/23168
    autocmd BufNewFile,BufRead *.ipynb set filetype=json

  augroup END
" }}}


" Personal mappings {{{

  " Status line: out until energy fully to customize airline
  " set ruler
  " set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

  " Leader
  let mapleader=","
  let localleader="\\"

  " Quit all buffers (without saving)
  nnoremap ZX :qa!<CR>

  " Quit all buffers (saving)
  nnoremap ZS :wqa!<CR>

  " Press Ctrl+h/l to scroll horizontally (as zh/yl)
  nnoremap <C-h> zh
  nnoremap <C-l> zl

  " Press Ctrl+j/k to scroll vertically (as Ctrl+e/y)
  " nnoremap <C-k> <C-y>
  " nnoremap <C-j> <C-e>

  " " Scroll screen lines
  " function ScreenScrollDown()
  "   norm! ml
  "   let to_bottom = winheight(0) - winline() + 1
  "   execute "norm! ". to_bottom . "gj"
  "   redraw!
  "   norm! `l
  " endfunction

  " function ScreenScrollUp()
  "   norm! ml
  "   execute "norm! ". winline() . "gk"
  "   redraw!
  "   norm! `l
  " endfunction
  " nnoremap <C-j> :call ScreenScrollDown()<CR>
  " vnoremap <C-j> :call ScreenScrollDown()<CR>
  " nnoremap <C-k> :call ScreenScrollUp()<CR>
  " vnoremap <C-k> :call ScreenScrollUp()<CR>

  " Press Alt+e/Alt+E for ge/gE (scroll backward to end of words)
  " (opposite of b/B, scroll backward to beginning of words)
  nnoremap <M-e> ge
  nnoremap <M-E> gE

  " Navigation to next punctuation using
  " Alt+) / Alt+(
  nnoremap ) /\v([,!?;:…(){}`’‘”“]\|' \| '\|\.+)<CR>:nohlsearch<CR>
  nnoremap ( ?\v([,!?;:…(){}`’‘”“]\|' \| '\|\.+)<CR>:nohlsearch<CR>

  " Buffers: {{{
  " delete buffer with ctrl+w+!
  nnoremap <C-w>! :bdelete!<CR>
  vnoremap <C-w>! :bdelete!<CR>
  " }}}

  " Windows: navigation {{{

  " Open vertical/horizontal:
  " (Vim default mapping: Ctrl_W+s for a new same file h split)

  " <localleader>nn for new file (in current window)
  nnoremap <localleader>nn :ene<CR>
  vnoremap <localleader>nn :<C-u>ene<CR>

  " Ctrl_W+Ctrl_n for a new split (same file)
  " Ctrl_W+n for a new split
  nnoremap <C-w>n :new<CR>
  vnoremap <C-w>n :<C-U>new<CR>
  nnoremap <C-w><C-n> :split<CR>
  vnoremap <C-w><C-n> :<C-U>split<CR>
  tnoremap <C-w>n <C-w>:new<CR>

  " same with Ctrl_W+s
  " (Ctrl_W+Ctrl_v already opens a split (same file)
  nnoremap <C-w>s :new<CR>
  vnoremap <C-w>s :<C-U>new<CR>
  tnoremap <C-w>s <C-w>:new<CR>

  " (Vim default mapping: Ctrl_W+Ctrl_v for a v split (same file)
  " Ctrl_W+v for a new v split
  nnoremap <C-w>v :vnew<CR>
  vnoremap <C-w>v :<C-u>vnew<CR>
  tnoremap <C-w>v <C-w>:vnew<CR>

  " Ctrl_W+. for the current dir (v)
  " Ctrl_W+, for the current dir (h)
  nnoremap <C-w>. :vsplit .<CR>
  vnoremap <C-w>. :<C-u>vsplit .<CR>
  tnoremap <C-w>. <C-w>:vsplit .<CR>
  nnoremap <C-w>, :split .<CR>
  vnoremap <C-w>, :<C-u>split .<CR>
  tnoremap <C-w>, <C-w>:split .<CR>
  " }}}

  " Window: resizing {{{
  " Horizontal alt+<, alt+> for incremental increase
  " (also in Terminal mode)
  if has('gui_running') " same key combinations as below
    nnoremap ® <C-W>>
    vnoremap ® <C-W>>
    tnoremap ® <C-W>>
    nnoremap ¬ <C-W><
    vnoremap ¬ <C-W><
    tnoremap ¬ <C-W><
  else
    nnoremap > <C-W>>
    vnoremap > <C-W>>
    tnoremap > <C-W>>
    nnoremap < <C-W><
    vnoremap < <C-W><
    tnoremap < <C-W><
  endif

  " Vertical alt+=, alt+- for incremental increase
  " (Not in Terminal mode)
  if has('gui_running') " same key combinations as below
    nnoremap ½ <C-W>-
    nnoremap ­ <C-W>+
  else
    nnoremap = <C-W>-
    nnoremap - <C-W>+
  endif

  " Maximizing the current window (opposite of ctrl+=)
  nnoremap <C-W># <C-W>\|<C-W>_

  " Diffing:
  nnoremap <leader>dth :diffthis<CR><C-w><C-w>:diffthis<CR><C-w>
  nnoremap <leader>dof :diffoff<CR><C-w><C-w>:diffoff<CR><C-w>
  " }}}

  " Tabs: {{{
  " Open new tab
  nnoremap <localleader>tt :tabedit<CR>
  vnoremap <localleader>tt :tabedit<CR>
  nnoremap <localleader>t. :tabedit .<CR>
  vnoremap <localleader>t. :tabedit .<CR>

  " Make current buffer full-screen (in new tab)
  nnoremap <C-w>T :tabedit %<CR>
  vnoremap <C-w>T :tabedit %<CR>

  " Cycle through tabs using tab, like standard editors
  " nnoremap <tab> gt
  " vnoremap <tab> gt
  " nnoremap <s-tab> gT
  " vnoremap <s-tab> gT
  " }}}


  " Useful command: switch window dir to dir of current file
  " :lcd %:p:h

  " Don't forget you can open : or / history thus (or Ctrl-F when in Ex mode):
  " q:, q/

  " Press Alt+[Line nav cmds] to scroll by visual (not logical) lines (useful for prose)
  noremap <M-j> gj
  noremap <M-k> gk
  noremap <M-h> g^
  noremap <M-l> g$
  noremap <M-0> g0

  " Cleaning: {{{
  " Auto indent whole file
  nnoremap <localleader>== gg=G

  " Removing empty lines (or lines with only space)
  nnoremap <localleader>;e :g/^[  \t]*$/d_<CR>:nohlsearch<CR>
  vnoremap <localleader>;e :g/^[  \t]*$/d_<CR>:nohlsearch<CR>

  " Merging consecutive empty/space-only lines
  " (taken from :help collapse)
  nnoremap <localleader>'e :g/^[  \t]*$/.,/[^  <Tab>]/-j<CR>:nohlsearch<CR>
  vnoremap <localleader>'e :g/^[  \t]*$/.,/[^  <Tab>]/-j<CR>:nohlsearch<CR>

  " Remove trailing whitespace (space, unbreakable space, tab)
  nnoremap <leader>rts :%s/[  \t]\+$//e<CR>:nohlsearch<CR>
  vnoremap <leader>rts :%s/[  \t]\+$//e<CR>:nohlsearch<CR>

  " Add underlining to a line with <localleader>--
  " And for one starting with a comment <localleader>-#
  " In visual mode only underlines selection
  nnoremap <Plug>HacksUnderline yypvg_r-:nohlsearch<CR>
        \ :call repeat#set("\<Plug>HacksUnderline", v:count)<CR>
  nmap <localleader>-- <Plug>HacksUnderline
  nnoremap <Plug>HacksUndercomment yypvg_r-r#lr :nohlsearch<CR>
        \ :call repeat#set("\<Plug>HacksUndercomment")<CR>
  nmap <localleader>-# <Plug>HacksUndercomment
  vnoremap <Plug>HacksUnderline yo"<ESC>^vg_r-:nohlsearch<CR>
        \ :call repeat#set("\<Plug>HacksUnderline", v:count)<CR>
  vmap <localleader>-- <Plug>HacksUnderline
  vnoremap <localleader>-- yo"<ESC>^vg_r-:nohlsearch<CR>
  " }}}

  " Vimrc edit, source & close
  if has('nvim')
    let $LEVIMRC = expand("~/.vimrc")
  else
    let $LEVIMRC = $MYVIMRC
  endif
  " echom "$LEVIMRC now " . $LEVIMRC . " but myvimrc " . $MYVIMRC
  nnoremap <leader>vv :edit $LEVIMRC<CR>
  nnoremap <leader>vt :tabe $LEVIMRC<CR>
  nnoremap <leader>ve :vsplit $LEVIMRC<CR>
  nnoremap <localleader>ve :split $LEVIMRC<CR>
  nnoremap <leader>vs :source $MYVIMRC<CR>
  nnoremap <leader>vc :bdelete ~/.vimrc<CR>

  " Press Esc twice to save buffer
  nnoremap <Esc><Esc> :w<CR>

  " Press Space to turn off highlighting and clear any message already displayed.
  " (last command removes Netrw messages)
  nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:call popup_clear()<CR>

  " Terminal: (& ex mode) {{{
  " Do not forget <C-F> to edit cmds in normal mode!
  " (& <C-E> to send it back to Ex mode)

  " Open with Alt+; in vertical split
  " <leader>Alt+: in horizontal
  nnoremap <C-w>; :vertical terminal zsh<CR><C-w>:echo<CR>
  nnoremap <C-w>: :terminal zsh<CR><C-w>:echo<CR>

  " Close from within with Ctrl+w+c/!
  " From any other window with <leader>tc
  nnoremap <leader>tc :bdelete! !zsh<CR>:echo<CR>
  tnoremap <C-w>c <C-w>:bdelete!<CR>:echo<CR>
  tnoremap <C-w>! <C-w>:bdelete!<CR>:echo<CR>

  " Browse the terminal in normal mode as you would in Ex mode
  tnoremap <C-f> <C-W>N

  " Ex navigation (emulating bash/zsh emacs binding)
  " Ctrl-a: home (same as Ctrl-b)
  " Ctrl+e: end (already implemented)
  " Alt-b: one word left
  " Alt-f: one word right
  " Ctrl-k: delete from cursor to the end of line
  " Alt-d/D: dw/dW in normal mode
  " Alt-e/E: de/dE in normal mode
  " cnoremap <C-a> <Home>
  " cnoremap <M-b> <S-Left>
  " cnoremap <M-f> <S-Right>
  " cnoremap <C-k> <C-f>d$<C-c>
  " cnoremap <M-d> <C-f>dw<C-c>
  " cnoremap <M-e> <C-f>de<C-c>

  " " check :help emacs-keys
  " " start of line
  " :cnoremap <C-A>   <Home>
  " " back one character
  " :cnoremap <C-B>   <Left>
  " " delete character under cursor
  " :cnoremap <C-D>   <Del>
  " " end of line
  " :cnoremap <C-E>   <End>
  " " forward one character
  " :cnoremap <C-F>   <Right>
  " " recall newer command-line
  " :cnoremap <C-N>   <Down>
  " " recall previous (older) command-line
  " :cnoremap <C-P>   <Up>
  " " back one word
  " :cnoremap <Esc><C-B>  <S-Left>
  " " forward one word
  " :cnoremap <Esc><C-F>  <S-Right>

  " (hopefully soon in terminal as well, to be researched)
  " tnoremap <C-a> <Home>
  " tnoremap <C-e> <End>
  " tnoremap â <S-Left>
  " tnoremap æ <S-Right>
  " }}}

  " Cutlass: overrides the delete operations to actually just delete {{{
  "          and not affect the current yank
  " <leader>keys now used to cut (and yank)
  nnoremap <leader>d d
  xnoremap <leader>d d

  nnoremap <leader>dd dd

  nnoremap <leader>D D
  xnoremap <leader>D D

  nnoremap <leader>S S
  xnoremap <leader>s s

  nnoremap <leader>C C
  xnoremap <leader>C C

  nnoremap <leader>c c

  nnoremap <leader>cc cc

  nnoremap <leader>x x
  xnoremap <leader>x x

  nnoremap <leader>X X
  xnoremap <leader>X X
  " }}}

  " Yoink: automatically maintain a history of yanks {{{
  " <c-n> / <c-p> to scroll through yanks
  nmap <c-n> <plug>(YoinkPostPasteSwapBack)
  nmap <c-p> <plug>(YoinkPostPasteSwapForward)

  " p / P remapped to Yoink
  nmap p <plug>(YoinkPaste_p)
  nmap P <plug>(YoinkPaste_P)

  " Permanently cycle through yank history
  nmap [y <plug>(YoinkRotateBack)
  nmap ]y <plug>(YoinkRotateForward)

  " Toggle whether current paste is formatted or not
  nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

  " Cursor not moving after performing a yank
  nmap y <plug>(YoinkYankPreserveCursorPosition)
  xmap y <plug>(YoinkYankPreserveCursorPosition)

  " Cutlass: Add cut operator to yank history
  let g:yoinkIncludeDeleteOperations=1
  let g:yoinkSyncNumberedRegisters=1
  " }}}

  " Subversive: two new operator motions to perform quick substitutions {{{
  " <leader>s for substitute
  nmap <localleader>s <plug>(SubversiveSubstitute)
  nmap <localleader>ss <plug>(SubversiveSubstituteLine)
  nmap <localleader>S <plug>(SubversiveSubstituteToEndOfLine)

  " <localleader><localleader>s for specifying both the text to replace and the range
  " over which to apply the substitutions
  nmap <localleader><localleader>s <plug>(SubversiveSubstituteRange)
  xmap <localleader><localleader>s <plug>(SubversiveSubstituteRange)
  nmap <localleader><localleader>ss <plug>(SubversiveSubstituteWordRange)

  " To confirm each substitution
  nmap <localleader>sc <plug>(SubversiveSubstituteRangeConfirm)
  xmap <localleader>sc <plug>(SubversiveSubstituteRangeConfirm)
  nmap <localleader>scr <plug>(SubversiveSubstituteWordRangeConfirm)

  " To use Tim Pope's Abolish plugin
  nmap <localleader>sv <plug>(SubversiveSubvertRange)
  xmap <localleader>sv <plug>(SubversiveSubvertRange)
  nmap <localleader>ssv <plug>(SubversiveSubvertWordRange)
  " }}}

  " Fugitive: a git wrapper {{{
  " Go up one level when browsing directories of a git repo
  " Cf. http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/

  " delete buffers
  " https://stackoverflow.com/a/3156541
  function! DeleteBuffersByPattern(pat)
    execute 'silent! bdelete .git/index'
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ "' . a:pat . '"')
    if empty(buffers) | return | endif
    " if empty(buffers) | throw "no fugitive buffers (" . a:pat . ")" | endif
    execute 'silent! bdelete ' . join(buffers, ' ')
  endfunction

  " open/close Fugitive buffer with <localleader>gg / gc
  nmap <localleader>gg :Git<CR>
  nmap <localleader>gc :call DeleteBuffersByPattern('.git/index')<CR>
  nmap <localleader>gd :call DeleteBuffersByPattern('^fugitive*')<CR>

  augroup Fugitive
    autocmd User fugitive
      \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
      \   nnoremap <buffer> .. :edit %:h<CR> |
      \ endif

    " Autoclean fugtive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup END

  " open the same file in a vertical split right, select the oldest version in
  " fugitive, and got back to the original pane
  nnoremap <localleader>0gl <C-w><C-v>:0Gclog<CR><C-w>jG<CR><C-W>h
  " when a futigive buffer & the quicklist are open on the right-hand-side
  " vsplit, close them both
  nnoremap <localleader>0gc <C-w>l<C-w>j<C-w>q<C-w>q
  " open one line log
  cabbrev glo Git log --oneline
  " }}}

  " Goyo: toggle with <leader>yy
  nnoremap <leader>yy :Goyo<CR>
  vnoremap <leader>yy :Goyo<CR>

  " YouCompleteMe: disable preview window after completion
  let g:ycm_autoclose_preview_window_after_insertion = 1
  let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf_openframeworks.py"

  " EasyAlign: just because I love Junegunn
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

  " Eunuch: some mappings
  nmap <localleader><localleader>D :Delete<CR>
  vmap <localleader><localleader>D :Delete<CR>
  nmap <localleader><localleader>R :Remove<CR>
  vmap <localleader><localleader>R :Remove<CR>

  " Grep Operator: search using movements
  set grepprg=git\ grep\ -n\ $*
  nmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
  vmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
  nmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
  vmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
  let g:grep_operator_set_search_register = 1

  " UltiSnips: {{{
  let g:UltiSnipsEditSplit="vertical"
  " }}}

  " Compile: current file using <leader>rr {{{
  " The first command compiles (or, for Python, blackens), the second runs the
  " program right after using the % register, containing the name of the file,
  " and removing the extension ":r" (for root), see :help expand

  " Java
  augroup Java_shortcuts
    autocmd!
    autocmd FileType java silent nnoremap <buffer> <localleader>rr :w<CR>:!javac -classpath . %<CR>
    autocmd FileType java silent nnoremap <buffer> <leader>rr :w<CR>:execute "!javac -classpath . %; java " . expand('%:r')<CR>
  augroup END

  " C++
  augroup cpp_shortcuts
    autocmd!
    autocmd FileType cpp silent nnoremap <buffer> <localleader>rr :w<CR>:execute "!g++ -std=c++11 -o " . expand('%:r') . ".out " . expand('%')<CR>
    autocmd FileType cpp silent nnoremap <buffer> <leader>rr :w<CR>:execute "!g++ -std=c++11 -o " . expand('%:r') . ".out " . expand('%') . "; ./" . expand('%:r') . ".out"<CR>
    autocmd FileType cpp silent nnoremap <buffer> <localleader>ff :!make && make RunRelease<CR>
  augroup END

  " Python ~> use Black for cleaning things up
  augroup py_shortcuts
    autocmd!
    autocmd FileType python silent nnoremap <buffer> <localleader>rr :w<CR>:!black %:p<CR>
    autocmd FileType python silent nnoremap <buffer> <leader>rr :w<CR>:!python %:p<CR>
  augroup END

  " Markdown ~> use Firefox to open the file
  augroup md_shortcuts
    autocmd!
    autocmd FileType markdown silent nnoremap <buffer> <localleader>rr :w<CR>:!firefox %<CR>
  augroup END

  " Rust
  augroup rs_shortcuts
    autocmd!
    autocmd FileType rust silent nnoremap <buffer> <localleader>rr :w<CR>:!rustc %:p<CR>
    autocmd FileType rust silent nnoremap <buffer> <leader>rr :call CompileAndRunRust()<CR>
    function! CompileAndRunRust()
      :w | execute ":!rustc " . expand('%:p') . "; ./" . expand('%:r')
    endfunction
  augroup END

  " }}}

  " Abbreviations: {{{

  " Specify <buffer> when unabbreviating!
  " e.g.: :una <buffer> i

  " Open help in new tab
  cabbrev helt tab help
  cabbrev helv vert help

  " " Text editing in .txt and .md
  " augroup text_edition
  "   autocmd!
  "   " open a multiline code block with ``
  "   autocmd FileType text,markdown,tex iabbrev <buffer> i I
  "   " i to I
  "   autocmd FileType text,markdown iabbrev <buffer> `` ``````O
  " augroup END

  " Python
  augroup py_abbrev
    autocmd!
    " the __main__ thingy
    autocmd FileType python iabbrev <buffer> if_
          \ def main():<CR>
          \pass<CR><CR><CR>
          \if __name__ == "__main__":<CR>
          \main()

    " the __main__ thingy with args
    autocmd FileType python iabbrev <buffer> ifa_
          \ if __name__ == "__main__":<CR><CR>
          \parser = argparse.ArgumentParser(description="""""")<CR><CR>
          \parser.add_argument("", "",<CR>type=,<CR>default="",<CR>help="""""")<CR><CR>
          \args = parser.parse_args()<CR><CR>main(args)

    " the __main__ thingy with args, full package
    autocmd FileType python iabbrev <buffer> ifa__
          \ import argparse<CR><CR>
          \def main(args):<CR>
          \pass<CR><CR><CR>
          \if __name__ == "__main__":<CR><CR>
          \parser = argparse.ArgumentParser(description="""""")<CR><CR>
          \parser.add_argument("", "",<CR>type=,<CR>default="",<CR>help="""""")<CR><CR>
          \args = parser.parse_args()<CR><CR>
          \main(args)

    " multiline comment strings
    autocmd FileType python iabbrev <buffer>
        \ """" """<CR>"""<ESC>O

  augroup END

  " " Automatic bracket matching {{{
  " " https://stackoverflow.com/questions/4521818/automatically-insert-a-matching-brace-in-vim
  " inoremap { {}<ESC>i
  " inoremap ( ()<ESC>i
  " inoremap [ []<ESC>i
  " inoremap " ""<ESC>i
  " inoremap ' ''<ESC>i
  " inoremap ` ``<ESC>i
  " " }}}

  " " remove space after abbrev (from :help abbreviations)
  " func Eatchar(pat)
  "    let c = nr2char(getchar(0))
  "    return (c =~ a:pat) ? '' : c
  " endfunc
  " iabbr <silent> if if ()<Left><C-R>=Eatchar('\s')<CR>

  " Javascript {{{
  augroup js_abbrev

    autocmd!

    autocmd FileType javascript iabbrev <buffer> $ ${}<ESC>i

  augroup END
  " }}}

  " Utils: varia

  " Save word/line {{{
  " produce a txt file name from the current line
  " (removing spaces and using '-' between words)
  " and saves the file in the current dir
  function! SaveWordLine(write)
    let l:line = getline('.')
    let l:line = substitute(line, "*", "", "g")
    let l:line = substitute(line, ", ", ",", "g")
    let l:line = substitute(line, "[  '\"?!;:]", "-", "g")
    let l:line = substitute(line, "/", "-", "g")
    let l:line = substitute(line, "-\\+", "-", "g")
    echom line
    let l:line = line . ".txt"
    if a:write==1
      execute "w " . line
    else
      execute "normal! o\<ESC>"
      call setline('.', line)
    endif
  endfunction

  function! SaveFormattedLine()
    execute "w " . getline('.')
    normal dd
    write
  endfunction

  nnoremap <leader>ww :call SaveWordLine(1)<CR>
  vnoremap <leader>ww :call SaveWordLine(1)<CR>
  nnoremap <localleader>ww :call SaveWordLine(0)<CR>
  vnoremap <localleader>ww :call SaveWordLine(0)<CR>
  nnoremap <leader>wr :call SaveFormattedLine()<CR>
  vnoremap <leader>wr :call SaveFormattedLine()<CR>
  " }}}

  " Split chain line {{{
  " Split line at char (current line will stop there, next one will have
  " blanks up until the char and the rest of the line after that.)
  " Cursor must be on the character where the split will occur.
  nnoremap <silent> <Plug>ChainSplit moyyp`ojhv0r `oD/\w /e<CR>:nohlsearch<Bar>:echo<CR>:call repeat#set("\<Plug>ChainSplit")<CR>
  nmap <localleader>oo <Plug>ChainSplit

  " writing
  " Copy line and replace all chars with spaces (writing forth)
  nnoremap <localleader>bb yypVr A

  " case for |, with additional writing: same as oi, writing mode on the line above
  nnoremap <localleader>ou moyyp`ojhv0r `oDyyPVr A\|<ESC>i

  " adding special characters
  " case for ¬: same as oo, adding ¬ at the end of the top line
  nnoremap <silent> <Plug>ChainOneLine moyyp`ojhv0r `oC¬<ESC>/\w /e<CR>:nohlsearch<Bar>:echo<CR>:call repeat#set("\<Plug>ChainOneLine")<CR>
  nmap <localleader>op <Plug>ChainOneLine

  " case for |: same as op, with |
  nnoremap <silent> <Plug>ChainTwoLine moyyp`ojhv0r `oC\|<ESC>/\w /e<CR>:nohlsearch<Bar>:echo<CR>:call repeat#set("\<Plug>ChainTwoLine")<CR>
  nmap <localleader>oi <Plug>ChainTwoLine

  " }}}

  " insert current date in file (useful for markdown posts)
  " https://superuser.com/a/459391
  nnoremap <leader>date :exec 'normal i'.substitute(system("stat -c \%y " . expand('%')),"[\n]*$","","")<CR>

  " join paragraph
  nnoremap <localleader>P mmvipJ`m

  " format paragraph
  nnoremap <localleader>p gwip
  vnoremap <localleader>p gw

  " sort paragraph
  nnoremap <localleader>;; mmvip:sort<CR>`m
  nnoremap <localleader>:: mmvip:sort!<CR>`m

  " and to sort visually selected lines
  " https://vim.fandom.com/wiki/Sort_lines
  vnoremap <localleader>;; :sort<CR>
  vnoremap <localleader>:: :sort!<CR>

  " sort lines by length
  " https://stackoverflow.com/a/11531678
  function! SortByLength(direction) range
    " extract the length of the line and writing the number at the beginning
    " of the line
    silent execute a:firstline . "," . a:lastline . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/'
    " sorting up or down using sort! or sort
    if a:direction==1
      let l:excl='!'
    elseif a:direction==-1
      let l:excl=''
    endif
    " sorting & removing the initial number & space
    silent execute a:firstline . "," . a:lastline . 'sort' . l:excl .' n'
    silent execute a:firstline . "," . a:lastline . 's/^\d\+\s//'
  endfunction

  vnoremap <localleader>lu :'<,'>call SortByLength(1)<CR>
  vnoremap <localleader>ld :'<,'>call SortByLength(-1)<CR>

  " Highlight duplicate lines, taken from here:
  " https://stackoverflow.com/a/1270689
  function! HighlightRepeats() range
    let lineCounts = {}
    let lineNum = a:firstline
    while lineNum <= a:lastline
      let lineText = getline(lineNum)
      if lineText != ""
        let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
      endif
      let lineNum = lineNum + 1
    endwhile
    exe 'syn clear Repeat'
    for lineText in keys(lineCounts)
      if lineCounts[lineText] >= 2
        exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
      endif
    endfor
  endfunction

  command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()

" }}}


" Make Alt keys work in terminal mode  {{{
  if !has('gui_running') && !has('nvim')
    let c='a'
    while c <= 'z'
      exec "set <A-".c.">=\e".c
      exec "imap \e".c." <A-".c.">"
      let c = nr2char(1+char2nr(c))
    endw
    set timeout ttimeoutlen=5
  endif
" }}}


" Code folding, <leader>zz to toggle all folds, autosave {{{
  set foldenable
  set foldmethod=marker " manual,indent,expr,syntax,diff,marker
  set foldlevel=99

  " Toggle all folds
  nnoremap <leader>zz :call ToggleFold()<CR>

  " Function FoldMethod {{{
  let g:FoldMethod = 1
  fun! ToggleFold()
    if g:FoldMethod == 0
      exe "normal! zM"
      let g:FoldMethod = 1
    else
      exe "normal! zR"
      let g:FoldMethod = 0
    endif
  endfun
" }}}


" Autosave manual folds {{{
  " augroup AutoSaveFolds
  "   autocmd!
  "   autocmd BufWinLeave *.* mkview
  "   autocmd BufWinEnter *.* silent loadview
  " augroup END
" }}}
" }}}


" TextObjects: {{{

  " ae/ie:        entire buffer
  " al/il:        line
  " a#/i#:        comments
  "   a~:           (with trail. space)
  " axX/ixX:      between X (any char)
  " av/iv:        continuous line (ending in \)
  " af/if:        function (vim, c, java)
  "   aF/iF:        (with lead./trail. space)
  " af/if;        function (python)
  " ac/ic:        class (python)
  " ac/ic;        css objects
  "  +'ac/ic'       (when selected a bloc, to select parent)
  " a,/i,:        function parameter
  " ai/ii:        same indent level

  " mappings for comments
  let g:textobj_comment_no_default_key_mappings = 1
  xmap a# <Plug>(textobj-comment-a)
  omap a# <Plug>(textobj-comment-a)
  xmap i# <Plug>(textobj-comment-i)
  omap i# <Plug>(textobj-comment-i)
  xmap a~ <Plug>(textobj-comment-big-a)
  omap a~ <Plug>(textobj-comment-big-a)

  " mappings for between
  let g:textobj_between_no_default_key_mappings = 1
  xmap ax <Plug>(textobj-between-a)
  omap ax <Plug>(textobj-between-a)
  xmap ix <Plug>(textobj-between-i)
  omap ix <Plug>(textobj-between-i)

  " http://vim.wikia.com/wiki/Indent_text_object
  onoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR>
  onoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR>
  vnoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR><Esc>gv
  vnoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR><Esc>gv

  " Function s:IndTxtObj {{{
  function! s:IndTxtObj(inner)
    let curline = line(".")
    let lastline = line("$")
    let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
    let i = i < 0 ? 0 : i
    if getline(".") !~ "^\\s*$"
      let p = line(".") - 1
      let nextblank = getline(p) =~ "^\\s*$"
      while p > 0 && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
        -
        let p = line(".") - 1
        let nextblank = getline(p) =~ "^\\s*$"
      endwhile
      normal! 0V
      call cursor(curline, 0)
      let p = line(".") + 1
      let nextblank = getline(p) =~ "^\\s*$"
      while p <= lastline && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
        +
        let p = line(".") + 1
        let nextblank = getline(p) =~ "^\\s*$"
      endwhile
      normal! $
    endif
  endfunction
  "}}}
"}}}


" Plugins (Vim-plug) {{{

  " Autoinstallation {{{
  " https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
  if empty(glob('~/.vim/autoload/plug.vim'))
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  " }}}


" Declare the list of plugins.
  call plug#begin('~/.vim/plugged')
    Plug 'vim-latex/vim-latex', {'for': 'tex', 'do': ':!ln -s \"$HOME/.vim/plugged/vim-latex\" \"$HOME/.vim/vim-latex\"'}
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-entire'
    Plug 'kana/vim-textobj-function', {'for': ['vim', 'c', 'java']}
    Plug 'bps/vim-textobj-python', {'for': 'python'}
    " Plug 'pangloss/vim-javascript', {'for': 'javascript'}
    Plug 'yuezk/vim-js', {'for': 'javascript'}
    Plug 'jasonlong/vim-textobj-css', {'for': ['css', 'sass', 'scss']}
    Plug 'kana/vim-textobj-line'
    Plug 'glts/vim-textobj-comment'
    Plug 'sgur/vim-textobj-parameter'
    Plug 'thinca/vim-textobj-between'
    Plug 'rhysd/vim-textobj-continuous-line'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-eunuch'
    Plug 'machakann/vim-sandwich'
    if has('nvim')
      Plug 'overcache/NeoSolarized'
    else
      Plug 'altercation/vim-colors-solarized'
    endif
    Plug 'vim-scripts/visualrepeat'
    Plug 'svermeulen/vim-cutlass'
    Plug 'svermeulen/vim-yoink'
    Plug 'svermeulen/vim-subversive'
    Plug 'junegunn/goyo.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'machakann/vim-highlightedyank'
    Plug 'prettier/vim-prettier', {
          \ 'do': 'npm -g install',
          \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
    Plug 'vim-scripts/indentpython.vim', {'for': 'python'}
    Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['cpp', 'c']}
    Plug 'ycm-core/YouCompleteMe', {'for':
          \ ['python', 'c', 'cpp', 'javascript', 'java'],
          \ 'do': './install.py --clangd-completer'}
    Plug 'MaxMEllon/vim-jsx-pretty', {'for': 'javascript'}
    " Plug 'psf/black', {'for':'python'} " does not work as current Vim is compiled with Python < 3.6
    Plug 'tomlion/vim-solidity', {'for': 'solidity'}
    Plug 'junegunn/fzf', {'dir':'~/.fzf', 'do':'./install --all'}
    Plug 'junegunn/vim-easy-align'
    Plug 'SirVer/ultisnips', {'for': ['markdown', 'javascript']}
    Plug 'nelstrom/vim-visual-star-search'
    Plug 'inside/vim-grep-operator'
    Plug 'vim-python/python-syntax', {'for': 'python'}
    call plug#end()
" }}}


" Vim-sandwich (surround) {{{
  runtime macros/sandwich/keymap/surround.vim
" }}}

" Python syntax {{{
let g:python_highlight_all = 1
" }}}

" Solarized, airline & colouring {{{

  if has('nvim')
    set termguicolors
    colorscheme NeoSolarized
  elseif has('gui_running')
    " syntax enable
    colorscheme solarized
    set background=light
    set linespace=2 " Underscore shown in gvim mode
    set winaltkeys=no " Disable Alt+[menukey]
    set guioptions-=m
    set guioptions-=T
  else
    " syntax enable
    colorscheme solarized
    " Unclear if needed now, to be researched
    " set t_Co=16
    let g:solarized_termcolors=256
    set background=dark
  endif

  " Airline: theme
  let g:airline_theme='solarized'
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#whitespace#skip_indent_check_ft =
        \  {'text': ['trailing'], 'markdown': ['trailing']}

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " Toggle background colour with <leader>bb {{{
  nnoremap <leader>bb :call ToggleBckgrnd()<CR>

  function! ToggleBckgrnd()
    if &background ==# "dark"
      set background=light
      let g:airline_solarized_bg="dark"
    else
      set background=dark
      let g:airline_solarized_bg="light"
    endif
  endfunction
  "}}}
" }}}

" Utils: beautifiers, minifiers {{{

  " JSON: beautifier/minifier (Linux/Bash):
  " https://blog.realnitro.be/2010/12/20/format-json-in-vim-using-pythons-jsontool-module/
  " https://stedolan.github.io/jq/
  nnoremap <leader>jsb  :%!jq .<CR> " jsb: 'json beautifier'
  nnoremap <leader>jsm  :%!jq -c .<CR> "jsm: 'json minifier'

  " Other JS beautifier (npm js-beautify) {{{
  " https://coderwall.com/p/m2kp5q/invoke-js-beautify-in-vim
  function! PrettyJS()
    %!js-beautify -s=2 -j -q -B
  endfunction
  command! Pjs call PrettyJS()
  " }}}

  " Yet another Json beautifier (Python) {{{
  " https://blog.realnitro.be/2010/12/20/format-json-in-vim-using-pythons-jsontool-module/
  function! PrettyJson()
    %!python -m json.tool
  endfunction
  command! Pjson call PrettyJson()
  " }}}

  " XML: beautifier using <leader>xmb {{{
  nnoremap <leader>xmb :call DoPrettyXML()<CR>

  " function DoPrettyXML {{{
  function! DoPrettyXML()
    " save the filetype so we can restore it later
    let l:origft = &ft
    set ft=
    " delete the xml header if it exists. This will
    " permit us to surround the document with fake tags
    " without creating invalid xml.
    1s/<?xml .*?>//e
    " insert fake tags around the entire document.
    " This will permit us to pretty-format excerpts of
    " XML that may contain multiple top-level elements.
    0put ='<PrettyXML>'
    $put ='</PrettyXML>'
    silent %!xmllint --format -
    " xmllint will insert an <?xml?> header. it's easy enough to delete
    " if you don't want it.
    " delete the fake tags
    2d
    $d
    " restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<
    " back to home
    1
    " restore the filetype
    exe "set ft=" . l:origft
  endfunction
  " }}}
  " }}}
" }}}


" Vim LaTeX {{{

  " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
  " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
  " The following changes the default filetype back to 'tex':
  let g:tex_flavor='latex'
  let g:Tex_DefaultTargetFormat = 'pdf'
  let g:Tex_MultipleCompileFormats='pdf, au'
  " let g:Tex_CompileRule_pdf='mkdir o; latex --interaction=nonstopmode --output-directory=o $*'
  let g:Tex_CompileRule_pdf='mkdir o; xelatex --interaction=nonstopmode --output-directory=o $*; mv o/*.pdf .'
" }}}


" Fonts adjustments in the gui using C-UP/C-DOWN {{{

  nmap <C-UP> :call LargerFont()<CR>
  nmap <C-DOWN> :call SmallerFont()<CR>

  set guifont=Monospace\ 10
  let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
  let s:minfontsize = 6
  let s:maxfontsize = 24

  " Function AdjustFontSize {{{
  function! AdjustFontSize(amount)
    if has("gui_gtk2") && has("gui_running")
      let fontname = substitute(&guifont, s:pattern, '\1', '')
      let cursize = substitute(&guifont, s:pattern, '\2', '')
      let newsize = cursize + a:amount
      if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
        let newfont = fontname . newsize
        let &guifont = newfont
      endif
    else
      echoerr "You need to run the GTK2 version of Vim to use this function."
    endif
  endfunction
  " }}}


  " Function LargerFont {{{
  function! LargerFont()
    call AdjustFontSize(1)
  endfunction
  command! LargerFont call LargerFont()
  " }}}


  " Function SmallerFont {{{
  function! SmallerFont()
    call AdjustFontSize(-1)
  endfunction
  command! SmallerFont call SmallerFont()
  " }}}
" }}}
