vim.keymap.set('n', '<leader>e', '<cmd>:Lexplore<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>:q<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>:w<cr>')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>z', '<cmd>:ZenMode<CR>')

local virtual_text_enabled = true

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle diagnostics virtual text" })
