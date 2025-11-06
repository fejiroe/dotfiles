return { 'neovim/nvim-lspconfig',
    config = function()
        vim.lsp.enable('sourcekit')
        vim.lsp.enable('zls')
    end
}
