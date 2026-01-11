return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    config = function() 
        local treesitter = require('nvim-treesitter')
        treesitter.setup()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = {'c', 'cpp', 'rust', 'vim', 'vimdoc', 'markdown', 'swift', 'bash'},
            callback = function ()
                vim.treesitter.start()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end
}
