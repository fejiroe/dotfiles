vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.incsearch = true      
vim.o.inccommand = 'split'

vim.cmd('filetype plugin on')
vim.o["termguicolors"] = true

vim.o.expandtab = true 
vim.o.softtabstop = 4 
vim.o.shiftwidth = 4 

vim.o.undofile = true

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.g.have_nerd_font = true
vim.o.cursorline = true

vim.o.showmode = false

vim.o.splitright = true
vim.o.splitbelow = true

vim.cmd('let g:netrw_winsize = 30')
vim.cmd('let g:netrw_keepdir = 0')

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})


-- PLUGINS --

-- sc server
local function scstatus()
    if vim.bo.filetype == "supercollider" then
        stat = vim.fn["scnvim#statusline#server_status"]()
        stat = stat:gsub("%%", "♪")
        return stat
    else
        return ""
    end
end

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
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-lualine/lualine.nvim',
        'davidgranstrom/scnvim',
        'saghen/blink.cmp',
        'tpope/vim-fugitive',
        'nvim-telescope/telescope.nvim',
        'xzbdmw/colorful-menu.nvim',
        'helbing/aura.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    opts = {colorscheme = 'aura'},
    ui = {
        border = "single",
        size = {
            width = 0.81,
            height = 0.81,
        },
    },
    checker = { enabled = true },
})

-- treesitter, lsp & blinkcmp
require('blink.cmp').setup {
    version = '.*',
    completion = {
        menu = {
            draw = {
                columns = { { "kind_icon" }, { "label", gap = 1 } },
                components = {
                    label = {
                        text = function(ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    },
                },
            },
            border = 'single',
            auto_show = false,
        },
        documentation = {window ={border = 'single' }},
    },
    fuzzy = { implementation = 'rust'},
    keymap = {
        preset = 'default',
        ['<C-c>'] = {'show'},
    },
}

require'nvim-treesitter.configs'.setup {
    build = ":TSUpdate",
    ensure_installed = { "asm", "c", "cpp", "lua", "vim", "vimdoc",  "markdown", "markdown_inline", "swift", "rust", "zig" },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
vim.lsp.enable('treesitter')

vim.cmd[[set completeopt+=menuone,noselect,popup]]

-- lua line

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
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
        lualine_c = {'filename', scstatus},
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
-- telescope
require('telescope').setup({
    defaults = {
        border = {
            prompt = { 1, 1, 1, 1 },
            results = { 1, 1, 1, 1 },
            preview = { 1, 1, 1, 1 },
        },
        borderchars = {
            prompt = { " ", " ", "─", "│", "│", " ", "─", "└" },
            results = { "─", " ", " ", "│", "┌", "─", " ", "│" },
            preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
        },
        layout_config = {
            horizontal = {
                size = {
                    width = "90%",
                    height = "60%",
                },
            },
            vertical = {
                size = {
                    width = "90%",
                    height = "90%",
                },
            },
        },
    }
})
vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg = 'none' })

-- supercollider
local scnvim = require 'scnvim'
local map = scnvim.map
local map_expr = scnvim.map_expr
scnvim.setup {
    -- config here
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

-- theming
vim.cmd [[:colorscheme aura]]
vim.cmd [[
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight NormalFloat guibg=none
]]

vim.cmd[[:highlight Pmenu guibg=#000000 cterm=NONE term=NONE]] 
vim.cmd[[:highlight CursorLine guibg=#111333 blend=100]]
--vim.api.nvim_set_hl(dark, 'CursorLine', { underline = true })

-- keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

