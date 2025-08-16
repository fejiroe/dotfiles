vim.keymap.set('n', '<leader>e', '<cmd>:Lexplore<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>:q!<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>:w<cr>')
vim.keymap.set('n', '<A-t>', '<cmd>:8sp +te<cr>')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

--[[
local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set(
        "n", 
        "<leader>a", 
        function()
            vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
            -- or vim.lsp.buf.codeAction() if you don't want grouping.
        end,
        { silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n", 
        "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
        function()
            vim.cmd.RustLsp({'hover', 'actions'})
        end,
        { silent = true, buffer = bufnr }
        ]]--

