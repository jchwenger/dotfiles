" Basic settings {{{
  scriptencoding utf-8
  set number
  set relativenumber
  set showcmd

  set nocompatible
  syntax on
  set hlsearch
  set incsearch
  set autoread
  " set spell

  filetype on
  filetype plugin on
  filetype indent on

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
" }}}


" Netrw: same-window mode with <c-a>, back to file with <c-^> {{{
" See: http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
" Also Tim Pope's Vim Vinegar: https://github.com/tpope/vim-vinegar
  let g:netrw_banner=0
  let g:netrw_liststyle=1
  let g:netrw_browse_split=0
" Hide dot files, toggle with 'gh'
  let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Call netrw
  nnoremap <c-a> :e.<cr>
" }}}


" Netrw: tree mode, removing banner, toggle with <alt-a> {{{
" https://shapeshed.com/vim-netrw/
" For now left aside because of this bug:
" https://github.com/vim/vim/issues/3276
  " let g:netrw_banner = 0
" Toggle Netrw with C-a {{{
" (https://vi.stackexchange.com/questions/10988/toggle-explorer-window/17684#17684)
  let g:NetrwIsOpen=0

" Netrw mapping
  noremap <silent> <m-a> :call ToggleNetrw()<cr>

  function! ToggleNetrw()
    if g:NetrwIsOpen
      let i = bufnr("$")
      while (i >= 1)
        if (getbufvar(i, "&filetype") == "netrw")
          silent exe "bwipeout " . i
        endif
        let i-=1
      endwhile
      let g:NetrwIsOpen=0
      " Reset netrw to defaults
      let g:netrw_liststyle=1
      let g:netrw_browse_split=0
    else
      let g:NetrwIsOpen=1
      " Set netrw to drawer style
      let g:netrw_liststyle=3
      let g:netrw_browse_split=5
      let g:netrw_winsize=25
      silent Lexplore
    endif
  endfunction
" }}}
" }}}


" Ctags {{{
" https://stackoverflow.com/a/33652614

" set tags+=.tags;$HOME
  nnoremap <leader>ct :!ctags -R .<cr>
"}}}


" Settings by file types {{{
  augroup silent FileTypeSettings

    autocmd!

    " Vim
    autocmd FileType vim setlocal
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

    " Text
    autocmd FileType text setlocal
          \ tabstop=2
          \ shiftwidth=2
          \ softtabstop=2
          \ wrap
          \ nolist
          " \ showbreak= 
                              " nolist required for
                              " linebreak (don't break words)
                              " first char of visual lines set
                              " as an nonbreakable space (not
                              " displayed here but typed:
                              " <c-v> u 202f)

    " Web &c
    autocmd FileType ruby,javascript,html,htmldjango,css,xml setlocal
          \ tabstop=2
          \ shiftwidth=2
          \ softtabstop=2
          \ autoindent
          \ nowrap
          \ iskeyword+=-

    " Markdown
    autocmd FileType markdown setlocal
          \ tabstop=2
          \ softtabstop=2
          \ shiftwidth=2
          \ autoindent
          \ wrap

    " LaTex
    autocmd FileType tex setlocal
          \ tabstop=2
          \ softtabstop=2
          \ shiftwidth=2
          \ autoindent
          \ wrap
          \ iskeyword+=:  " TIP: if you write your \label's as \label{fig:something},
                          " then if you type in \ref{fig: and press <C-n>
                          " you will automatically cycle through all
                          " the figure labels. Very useful! (See Vim LaTeX below)


    " Java
    autocmd FileType java setlocal
          \ tabstop=4
          \ softtabstop=4
          \ shiftwidth=4
          \ autoindent

  augroup END
" }}}


" Personal mappings {{{

" Status line
  set ruler
  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Leader
  let mapleader=","
  let localleader="\\"

" Quit all buffers (without saving)
  nnoremap ZX :qa!<CR>

" Quit all buffers (saving)
  nnoremap ZS :wqa!<cr>

" Press Ctrl+h/l to scroll horizontally (as zh/yl)
  nnoremap <C-h> zh
  nnoremap <C-l> zl

" Press Ctrl+j/k to scroll vertically (as Ctrl+e/y)
  nnoremap <C-k> <C-y>
  nnoremap <C-j> <C-e>

" Press Alt+e/Alt+E for ge/gE (scroll backward to end of words)
" (opposite of b/B, scroll backward to beginning of words)
  nnoremap <M-e> ge
  nnoremap E gE

" Window resizing: horizontal alt+<, alt+>
" (also in Terminal mode)
  nnoremap > <C-W>>
  nnoremap < <C-W><
  tnoremap > <C-W><
  tnoremap < <C-W>>

" Window resizing: vertical alt+=, alt+-
  nnoremap = <C-W>-
  nnoremap - <C-W>+

" Press Alt+[Line nav cmds] to scroll by visual (not logical) lines (useful for prose)
  noremap <M-j> gj
  noremap <M-k> gk
  noremap <M-h> g^
  noremap <M-l> g$
  noremap <M-0> g0

" Auto indent whole file
  nnoremap <leader>== gg=G

" Vimrc edit, source & close
  nnoremap <leader>vv :e $MYVIMRC<CR>
  nnoremap <leader>ve :vsplit $MYVIMRC<CR>
  nnoremap <leader>vs :source $MYVIMRC<CR>
  nnoremap <leader>vc :bdelete ~/.vimrc<CR>

" Press Esc twice to save buffer
  nnoremap <Esc><Esc> :w<CR>

" Press Space to turn off highlighting and clear any message already displayed.
  nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Terminal: open
  nnoremap <leader>tt :vertical terminal<CR>

" Terminal: close from within with <C-W>,,
"           from any other window with <leader>tc
  nnoremap <leader>tc :bdelete! !/usr/bin/zsh<CR>
  tnoremap <C-W><leader><leader> <C-W>:bdelete! !/usr/bin/zsh<CR>

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

  " Add cut operator (Cutlass) to yank history
  let g:yoinkIncludeDeleteOperations=1
  let g:yoinkSyncNumberedRegisters=0
" }}}
"
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
" }}}
" }}}

" Fugitive: a git wrapper {{{
  " Go up one level when browsing directories of a git repo
  " Cf. http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
  augroup Fugitive
    autocmd User fugitive
      \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
      \   nnoremap <buffer> .. :edit %:h<CR> |
      \ endif

    " Autoclean fugtive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup END
" }}}

" Compile current file using <leader>rr
  "Java
  augroup Java_shortcuts
    autocmd FileType java silent
        nnoremap <leader>rr :!javac -classpath . %<cr>
  augroup END
" }}}


" Make Alt keys work in terminal mode  {{{
  if !has('gui_running')
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
  let g:FoldMethod = 0
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
  augroup AutoSaveFolds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview
  augroup END
" }}}
" }}}


" Text objects: {{{
" Indent, using 'i', ai/ii
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


  call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
  Plug '~/.vim/vim-latex-1.10.0', {'for': 'tex'}
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-entire'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-fugitive'
  Plug 'altercation/vim-colors-solarized'
  Plug 'vim-scripts/visualrepeat'
  Plug 'svermeulen/vim-cutlass'
  Plug 'svermeulen/vim-yoink'
  Plug 'svermeulen/vim-subversive'
  Plug 'junegunn/goyo.vim'
  call plug#end()
" }}}


" Solarized & colouring {{{

" syntax enable
  colorscheme solarized

  if has('gui_running')
    set background=light
    set linespace=2 " Underscore shown in gvim mode
  else
    set t_Co=16
    let g:solarized_termcolors=256
    set background=dark
  endif
" }}}


" Toggle background colour with <leader>bb {{{
  nnoremap <leader>bb :call ToggleBckgrnd()<cr>
  function! ToggleBckgrnd()
    if &background ==# "dark"
      set background=light
    else
      set background=dark
    endif
  endfunction
"}}}


" Utils: beautifiers, minifiers {{{

" Json beautifier/minifier (Linux/Bash):
" https://blog.realnitro.be/2010/12/20/format-json-in-vim-using-pythons-jsontool-module/
" https://stedolan.github.io/jq/
  nnoremap <leader>jsb  :%!jq .<cr> " jsb: 'json beautifier'
  nnoremap <leader>jsm  :%!jq -c .<cr> "jsm: 'json minifier'

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


" XML beautifier using <leader>xmb {{{
  nnoremap <leader>xmb :call DoPrettyXML()<cr>

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
  let g:tex_flavor='xelatex'
  let g:Tex_DefaultTargetFormat = 'pdf'
  let g:Tex_CompileRule_pdf='xelatex --interaction=nonstopmode $*'

  let g:Tex_DefaultTargetFormat = 'pdf'
  let g:Tex_MultipleCompileFormats='pdf, aux'
" }}}


" Fonts adjustments in the gui using C-UP/C-DOWN {{{

  nmap <C-UP> :call LargerFont()<CR>
  nmap <C-DOWN> :call SmallerFont()<CR>

  set guifont=Monospace\ 14
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
