return {
    'helbing/aura.nvim',
    --'baliestri/aura-theme',
    --'miikanissi/modus-themes.nvim',
    --'maxmx03/fluoromachine.nvim',
    --'olivercederborg/poimandres.nvim',
    priority = 1000,
    config = function()
        --vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
        vim.cmd([[colorscheme aura]])
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
