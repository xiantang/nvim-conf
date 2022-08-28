
call plug#begin()
Plug 'BrandonRoehl/auto-omni'
Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

lua require("lsp_config")
lua require("nvim-tree").setup()

set omnifunc=syntaxcomplete#Complete
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)

echo 'read config good now'
