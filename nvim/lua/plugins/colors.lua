return {
    'baliestri/aura-theme',
    config = function(plugin)
        vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
        vim.cmd([[colorscheme aura-dark]])
        vim.cmd [[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
        highlight NormalFloat guibg=none
        ]]
        vim.cmd[[:highlight Pmenu guibg=#000000 cterm=NONE term=NONE]] 
        vim.cmd[[:highlight CursorLine guibg=#111333 blend=100]]
    end
}
