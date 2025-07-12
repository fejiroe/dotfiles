vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.incsearch = true      
vim.o.inccommand = 'split'
vim.o.cursorline = true

vim.cmd('filetype plugin on')
vim.o["termguicolors"] = false

vim.o.expandtab = true 
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.o.undofile = true

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.g.have_nerd_font = true

vim.o.showmode = false

vim.o.splitright = true
vim.o.splitbelow = true

vim.cmd('let g:netrw_winsize = 30')
vim.cmd('let g:netrw_keepdir = 0')

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- lazy pm
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- add your plugins here
        'tpope/vim-fugitive',
        'nvim-treesitter/nvim-treesitter',
        'nvim-lualine/lualine.nvim',
        "xzbdmw/colorful-menu.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    ui = {
        border = "single",
        size = {
            width = 0.8,
            height = 0.8,
        },
    },
    checker = { enabled = true },
})

-- treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "asm", "c", "cpp", "lua", "vim", "vimdoc",  "markdown", "markdown_inline", "swift", "rust", "zig" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

vim.lsp.enable('treesitter')

-- lua line
local colors = {
    color0 = "#092236",
    color1 = "#ff5874",
    color2 = "#c3ccdc",
    color3 = "#1c1e26",
    color6 = "#a1aab8",
    color7 = "#828697",
    color8 = "#ae81ff",
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = '16color',
        component_separators = { left = '|', right = ''},
        section_separators = { left = '|', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 8, -- ~120fps
            events = {
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
            },
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- transparent background
vim.cmd [[
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
]]

-- keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


