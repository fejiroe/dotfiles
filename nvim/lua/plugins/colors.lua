return {
    'olivercederborg/poimandres.nvim',
    dependencies = {
        'xiyaowong/transparent.nvim',
    },
    priority = 1000,
    
    config = function()
        vim.o.background = "dark"
        vim.o.termguicolors = true
        vim.cmd("colorscheme poimandres")
        vim.g.transparent_enabled = true
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
