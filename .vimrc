" execute pathogen#infect()
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'SirVer/ultisnips'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

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
""" autocmd StdinReadPre * let s:std_in=1
""" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
""" " Close if only Nerdtree is open:
""" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
""" " Show hidden files
""" let NERDTreeShowHidden=1
""" " Use Ctrl+n to toggle nerdtree:
""" map <C-n> :NERDTreeToggle<CR>
""" " Custom maps
let mapleader = ","
""" nmap <leader>ne :NERDTree<cr>

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
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsExpandTrigger = '<s-cr>'

"""""""""""""
" Misc
"""""""""""""
" Search settings
set ic hls is
" Show line number and relative numbers (rnu)
set number " rnu
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
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
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
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Disable vim-go warnings
let g:go_version_warning = 0
let g:go_rename_command = 'gopls'


""""""""""""""""""""""""""""""""""""
" COC explorer
""""""""""""""""""""""""""""""""""""
nmap  e :CocCommand explorer --toggle<CR>


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

" FZF key bindings
nnoremap <C-f> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }
" Text search
nnoremap <C-g> :Rg<Cr>

" Mirror nerdtree in new tabs
"autocmd BufWinEnter * NERDTreeMirror
"autocmd tabenter * NERDTreeMirror
"autocmd vimenter * NERDTreeProjectLoadFromCWD
"autocmd vimleave * NERDTreeFocus | NERDTreeProjectCWD
"
autocmd FileType go setlocal noet ci pi sts=0 sw=4 ts=4

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

autocmd BufNewFile,BufRead *.yaml.gotmpl set syntax=yaml
