" Borrowed from Sane vim defaults for ArchLabs

" system clipboard (requires +clipboard)
set clipboard^=unnamed,unnamedplus

" additional settings
set modeline           " enable vim modelines
set confirm            " ask confirmation like save before quit.
set shortmess+=aAcIws  " Hide or shorten certain messages
set colorcolumn=80     " lines shouldn't go pass 80 columns

set spelllang=en_us
set spellfile=~/Dictionaries/vimspell/en.utf-8.add
set guifont=Menlo\ Regular:h12 

" ------ enable additional features ------

" enable mouse
set mouse=a
if has('mouse_sgr')
    " sgr mouse is better but not every term supports it
    set ttymouse=sgr
endif

set linebreak breakindent
set list listchars=tab:>>,trail:~

" ------ enable a colorscheme ------
colorscheme gruvbox
set background=dark

if $TERM !=? 'linux'
    set termguicolors

    " true colors in terminals (neovim doesn't need this)
    if !has('nvim') && !($TERM =~? 'xterm' || &term =~? 'xterm')
        let $TERM = 'xterm-256color'
        let &term = 'xterm-256color'
    endif

    if has('multi_byte') && $TERM !=? 'linux'
        set listchars=tab:»»,trail:•
        set fillchars=vert:┃ showbreak=↪
    endif
endif

" --------- Plugins configs ------------

" Emmet
let g:user_emmet_leader_key=','
"let g:user_emmet_expandabbr_key='<Tab>'
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" NerdTree
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']

" FZF

" Ale
let g:ale_lint_on_text_changed = 'never'    " lint only when file is saved
let g:ale_lint_on_enter = 0                 " don't lint when file is opened
let g:ale_sign_column_always = 1            " keep ale column open all the time
let g:ale_sign_error = '>>'                 " >> signals an error
let g:ale_sign_warning = '--'               " -- signals a warning

" MRU
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'

" Indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1

" Goyo and Limelight
function! s:goyo_enter()
  Limelight
  Pencil
  set spell
endfunction

function! s:goyo_leave()
  Limelight!
  PencilOff
  set nospell
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" --------- Aditional configs ----------

" change cursor shape for different editing modes, neovim does this by default
if !has('nvim')
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\e[4 q\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    else
        let &t_SI = "\e[6 q"
        let &t_SR = "\e[4 q"
        let &t_EI = "\e[2 q"
    endif
endif

" ------ commands ------

command! D Explore
command! R call <SID>ranger()
command! Q call <SID>quitbuffer()
command! -nargs=1 B :call <SID>bufferselect("<args>")
command! W execute 'silent w !sudo tee % >/dev/null' | edit!

" ------- functions --------

" quit the current buffer and switch to the next
" without this vim will leave you on an empty buffer after quiting the current
function! <SID>quitbuffer() abort
    let l:bf = bufnr('%')
    let l:pb = bufnr('#')
    if buflisted(l:pb)
        buffer #
    else
        bnext
    endif
    if bufnr('%') == l:bf
        new
    endif
    if buflisted(l:bf)
        execute('bdelete! ' . l:bf)
    endif
endfunction

" switch active buffer based on pattern matching
" if more than one match is found then list the matches to choose from
function! <SID>bufferselect(pattern) abort
    let l:bufcount = bufnr('$')
    let l:currbufnr = 1
    let l:nummatches = 0
    let l:matchingbufnr = 0
    " walk the buffer count
    while l:currbufnr <= l:bufcount
        if (bufexists(l:currbufnr))
            let l:currbufname = bufname(l:currbufnr)
            if (match(l:currbufname, a:pattern) > -1)
                echo l:currbufnr.': '.bufname(l:currbufnr)
                let l:nummatches += 1
                let l:matchingbufnr = l:currbufnr
            endif
        endif
        let l:currbufnr += 1
    endwhile

    " only one match
    if (l:nummatches == 1)
        execute ':buffer '.l:matchingbufnr
    elseif (l:nummatches > 1)
        " more than one match
        let l:desiredbufnr = input('Enter buffer number: ')
        if (strlen(l:desiredbufnr) != 0)
            execute ':buffer '.l:desiredbufnr
        endif
    else
        echoerr 'No matching buffers'
    endif
endfunction

" open ranger as a file chooser
function! <SID>ranger()
    let l:temp = tempname()
    execute 'silent !xterm -e ranger --choosefiles='.shellescape(l:temp).' $PWD'
    if !filereadable(temp)
        redraw!
        return
    endif
    let l:names = readfile(l:temp)
    if empty(l:names)
        redraw!
        return
    endif
    execute 'edit '.fnameescape(l:names[0])
    for l:name in l:names[1:]
        execute 'argadd '.fnameescape(l:name)
    endfor
    redraw!
endfunction
