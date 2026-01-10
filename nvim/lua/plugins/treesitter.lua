return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    config = function() 
        local treesitter = require('nvim-treesitter')
        treesitter.setup()
        --treesitter.install {'c', 'cpp', 'rust', 'vim', 'swift', 'bash'}
        vim.api.nvim_create_autocmd('FileType', {
            pattern = {'c', 'cpp', 'rust', 'vim', 'vimdoc', 'markdown', 'swift', 'bash'},
            callback = function ()
                vim.treesitter.start()
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo.foldmethod = 'expr'
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end
}
