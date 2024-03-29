autocmd User GnuPG setl textwidth=80
" Fast editing of the .vimrc
map <F9> :e $HOME/.vim_runtime/my_configs.vim<cr>

if has('gui_running')
  set guifont=Consolas:h10
endif

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim_runtime/my_configs.vim

map <leader>z ggVGzO

nnoremap <silent> <F11> :YRShow<CR>

"copy and paste
"vmap <C-c> "+yi
"vmap <C-x> "+c
"vmap <C-v> c<ESC>"+p
"imap <C-v> <ESC>"+pa
map <C-v> "+pa


""""""""""""""""""""""""""""""
" => Perl section
"""""""""""""""""""""""""""""""
let perl_fold=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Transpose lines
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allows you to move a line (or multiple lines) of text up or down within a document using the <Control> and <Up>/<Down> arrow keys. The mappings all take a count so 5<C-Up> would move the current line (or visual selection) 5 lines up.

function! MoveLineUp()
  call MoveLineOrVisualUp(".", "")
endfunction

function! MoveLineDown()
  call MoveLineOrVisualDown(".", "")
endfunction

function! MoveVisualUp()
  call MoveLineOrVisualUp("'<", "'<,'>")
  normal gv
endfunction

function! MoveVisualDown()
  call MoveLineOrVisualDown("'>", "'<,'>")
  normal gv
endfunction

function! MoveLineOrVisualUp(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num - v:count1 - 1 < 0
    let move_arg = "0"
  else
    let move_arg = a:line_getter." -".(v:count1 + 1)
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualDown(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num + v:count1 > line("$")
    let move_arg = "$"
  else
    let move_arg = a:line_getter." +".v:count1
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualUpOrDown(move_arg)
  let col_num = virtcol(".")
  execute "silent! ".a:move_arg
  execute "normal! ".col_num."|"
endfunction

nnoremap <silent> <C-k> :<C-u>call MoveLineUp()<CR>
nnoremap <silent> <C-j> :<C-u>call MoveLineDown()<CR>
inoremap <silent> <C-k> <C-o>:call MoveLineUp()<CR>
inoremap <silent> <C-j> <C-o>:call MoveLineDown()<CR>
"vnoremap <silent> <C-Up> :<C-u>call MoveVisualUp()<CR>
"vnoremap <silent> <C-Down> :<C-u>call MoveVisualDown()<CR>
xnoremap <silent> <C-k> :<C-u>call MoveVisualUp()<CR>
xnoremap <silent> <C-j> :<C-u>call MoveVisualDown()<CR>

let xml_jump_string = "'"
let g:xml_jump_string = "'"

" GPG Plugin options
let g:GPGPreferArmor = 1
let g:GPGDefaultRecipients = ["6E36D9ED"]
let g:GPGUseAgent = 0

autocmd! BufNew,BufRead *.gpg setlocal textwidth=80
autocmd! BufNew,BufRead *.txt setlocal textwidth=80

let g:vim_markdown_folding_disabled = 1
set conceallevel=2
let g:vim_markdown_autowrite = 1

let g:snipMate = { 'snippet_version' : 1 }
