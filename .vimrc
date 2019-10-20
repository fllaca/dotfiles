execute pathogen#infect()

filetype plugin on
filetype on
filetype plugin indent on

"""""""""""""""""""""""
" Synaxt Colors
""""""""""""""""""""""
set t_Co=256
" Background fix: https://serverfault.com/a/485732
set t_ut=
"colorscheme evening
colo monokai-soda
syntax on

"""""""""""""
" NERDTree
"""""""""""""
"Start NerdTree if directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Close if only Nerdtree is open:
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Show hidden files
let NERDTreeShowHidden=1
" Use Ctrl+n to toggle nerdtree:
map <C-n> :NERDTreeToggle<CR>
" Custom maps
let mapleader = ","
nmap <leader>ne :NERDTree<cr>

" Save working directory Tree on exit
" autocmd VimLeavePre * let current_dir=getcwd()
" autocmd VimLeavePre * execute ':NERDTreeProjectSave' . current_dir
" autocmd VimEnter * :NERDTreeProjectLoadFromCWD

"""""""""""""""""""""""
" YouCompleteMe + UltiSnips
"""""""""""""""""""""""
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"""""""""""""
" Misc
"""""""""""""
" Search settings
set ic hls is
" Show line number and relative numbers
set number rnu
" reload content
set autoread
" Update time lowered to 100ms in order to make GitGutter show the changes
" faster
set updatetime=100

" Number of spaces when auto indenting:
set shiftwidth=2

" replace the last search pattern with input text
nnoremap <c-h> :%s///gc<left><left><left>
" Make the visually selected text a search
vnoremap // y/<C-R>"<CR>

" Allow yanking multiple times
" (https://stackoverflow.com/questions/7163947/paste-multiple-times)
xnoremap p pgvy

" bash interactive mode when doing :!
set shellcmdflag=-ic


" see https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
" Not needed in nvim:
"execute "set <A-j>=\ej"
"execute "set <A-h>=\eh"
"execute "set <A-k>=\ek"
"execute "set <A-l>=\el"
"nnoremap <M-j> j
map <silent> <A-l> <C-w><
map <silent> <A-j> <C-W>-
map <silent> <A-k> <C-W>+
map <silent> <A-h> <C-w>>

"""""""""""""""""""""""""""""
" Whitespace highlighting
"""""""""""""""""""""""""""""
highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace:
" match ExtraWhitespace /\s\+$/
" Show trailing whitespace and spaces before a tab:
" match ExtraWhitespace /\s\+$\| \+\ze\t/
" Show tabs that are not at the start of a line:
"match ExtraWhitespace /[^\t]\zs\t\+/
" Show spaces used for indenting (so you use only tabs for indenting).
" match ExtraWhitespace /^\t*\zs \+/
" Switch off :match highlighting.
" match

autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd InsertLeave * redraw!

""""""""""""""""""""""""""""""""""""
" COC.nvim autocompletion plugin
""""""""""""""""""""""""""""""""""""
" Useful tips: https://octetz.com/posts/vim-as-go-ide
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
" expand snippet on ENTER: https://github.com/neoclide/coc.nvim/wiki/Using-snippets#snippet-completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" File search
" find files and populate the quickfix list
fun! FindFiles(filename)
  let error_file = tempname()
  silent exe '!find . -name "*'.a:filename.'*" | xargs file | sed "s/:/:1:/" > '.error_file
  set errorformat=%f:%l:%m
  exe "cfile ". error_file
  copen
  call delete(error_file)
endfun
command! -nargs=1 FindFile call FindFiles(<q-args>)
" find text in folder and populate the quickfix list
fun! FindText(filename)
  let error_file = tempname()
  silent exe '!grep -r -l "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
  set errorformat=%f:%l:%m
  exe "cfile ". error_file
  copen
  call delete(error_file)
endfun
command! -nargs=1 FindText call FindText(<q-args>)
