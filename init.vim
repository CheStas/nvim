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
set ignorecase
set smartcase
syntax on

call plug#begin()
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" to highlight syntax don't forget to run
" :TSInstall javascript, vue, css scss dockerfile html json json5 lua make php regex typescript vim
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdateSync'}
Plug 'nvim-treesitter/nvim-treesitter-context'
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
Plug 'glepnir/dashboard-nvim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" opt.listchars:append("space:.")
" opt.listchars:append("eol:")
let g:dashboard_default_executive = 'telescope'
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
  open_on_setup = true,
  view = {
    side = 'left',
    auto_resize = false,
    width = 60,
    number = true,
    relativenumber = false,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  }
}
EOF
lua require'telescope'.setup {}
lua require'telescope'.load_extension('fzf')

" advanced repgrep integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case '
  let initial_command = command_fmt.(a:query)
  "let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt.('%s'), '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:eval '.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" END advanced repgrep integration

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
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

" lovecrafts makers customer auto
" autocmd BufWritePost /Users/stas/projects/lovecrafts/makers/*/** !prettier --config /Users/stas/projects/lovecrafts/makers/.prettierrc --write %
autocmd BufWritePost /Users/stas/projects/lovecrafts/makers/*/** !/Users/stas/projects/lovecrafts/rebuild_makers.sh %
autocmd BufWritePost /Users/stas/projects/lovecrafts/graph-gateway/*/** !/Users/stas/projects/lovecrafts/rebuild_graph_gateway.sh %

nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fw <cmd>:Rg! <cr>
nnoremap tt <cmd>:NvimTreeToggle <cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap qf <Plug>(coc-fix-current)
" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)


