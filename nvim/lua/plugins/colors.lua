return {
    --'helbing/aura.nvim',
    --'baliestri/aura-theme',
    'miikanissi/modus-themes.nvim',
    --'maxmx03/fluoromachine.nvim',
    --'olivercederborg/poimandres.nvim',
    priority = 2000,
    config = function()
        --vim.cmd([[colorscheme aura]])
        vim.cmd([[colorscheme modus_vivendi]])
        vim.cmd [[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
        highlight NormalFloat guibg=none
        ]]
        vim.cmd[[:highlight Pmenu guibg=#000000 cterm=NONE term=NONE]] 
        vim.cmd[[:highlight CursorLine guibg=NONE cterm=underline]]
    end
}
