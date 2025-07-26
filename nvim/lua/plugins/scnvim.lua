return {
    'davidgranstrom/scnvim',
    config = function ()
        local scnvim = require 'scnvim'
        local map = scnvim.map
        local map_expr = scnvim.map_expr
        scnvim.setup {
            keymaps = {
                ['<M-e>'] = map('editor.send_line', {'i', 'n'}),
                ['<C-e>'] = {
                    map('editor.send_block', {'i', 'n'}),
                    map('editor.send_selection', 'x'),
                },
                ['<CR>'] = map('postwin.toggle'),
                ['<M-CR>'] = map('postwin.toggle', 'i'),
                ['<M-L>'] = map('postwin.clear', {'n', 'i'}),
                ['<C-k>'] = map('signature.show', {'n', 'i'}),
                ['<M-q>'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
                ['<leader>st'] = map(scnvim.start),
                ['<leader>sk'] = map(scnvim.recompile),
                ['<M-s>'] = map_expr('s.boot'),
                ['<F2>'] = map_expr('s.meter'),
            },
            postwin = {
                size = 42,
            },
            statusline = {
                poll_interval = 1,
            },
        }
        vim.g.scnvim_postwin_syntax_hl = 1
    end
}
