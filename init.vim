set number
set list
set relativenumber
set clipboard=unnamedplus
set expandtab
set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set updatetime=300
syntax on 

call plug#begin()
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'f-person/git-blame.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'projekt0n/github-nvim-theme'
Plug 'dense-analysis/ale'
call plug#end()

" opt.listchars:append("space:.")
" opt.listchars:append("eol:")
lua require("indent_blankline").setup {}
let g:show_end_of_line = "true"
let g:space_char_blankline = " "

let g:nvim_tree_open_on_setup = 1
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']
let g:airline_powerline_fonts = 1

lua <<EOF
require'github-theme'.setup{
  theme_style = "dark",
  keyword_style = "NONE",
 }
EOF
colorscheme github_dark

lua require'nvim-web-devicons'.setup {}
lua <<EOF
require'nvim-tree'.setup {
  view = {
    side = 'left',
    auto_resize = false,
    width = 30,
  }
}
EOF
lua require'telescope'.setup {}
lua require'telescope'.load_extension('fzf')
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" lovecrafts makers customer auto
autocmd BufWritePost /Users/stas/projects/lovecrafts/makers/*/** !/Users/stas/projects/lovecrafts/rebuild_makers.sh %
" lovecrafts makers end

nnoremap ff <cmd>Telescope find_files<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)


