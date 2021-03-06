" Minimal vim settings without plugins/bundles
let mapleader='\'

" Basic settings
"set number "sets numbers
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
"set cindent
set ignorecase
set vb " turns off visual bell
set history=50 " keep 50 lines of command line history
set ruler	" show the cursor position all the time
set showcmd	" display incomplete commands
set incsearch " do incremental searching
set hlsearch
set hidden
set backspace=indent,eol,start 
set wildmenu
set noswapfile
syntax on
colorscheme torte
filetype plugin indent on "Tell plugins and indents about the file

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

" Keyboard shortcuts
noremap <leader>s :set hls!<bar>set hls?<CR>
noremap <leader>p :set paste!<bar>set paste?<CR>
noremap <leader>g :grep <C-r><C-w><CR>:cw<CR>
noremap <leader>G :grep<space>
noremap gn :cn<CR>
noremap gN :cp<CR>
noremap <leader>c :!ctags -R --languages=
noremap <leader>] :tn<CR>
noremap <leader>[ :tp<CR>
noremap <leader>o :tselect<CR>
cnoremap %% <C-R>=expand('%:p:h')<CR>/
noremap <leader>v :e ~/.vimrc<CR>

" Abbreviations
autocmd Filetype python ab ipdb import ipdb; ipdb.set_trace()
autocmd Filetype python ab ifname if __name__ == '__main__':<CR>

" Remap buffer movement
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Automatically remove trailing whitespace in python files
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.js :%s/\s\+$//e

" Ignore certain filetypes
set wildignore+=*.so,*.swp,*.zip
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exeTag
set wildignore+=*.pyc

" Set up omnicomplete files
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
