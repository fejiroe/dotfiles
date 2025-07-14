vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.incsearch = true      
vim.o.inccommand = 'split'

vim.cmd('filetype plugin on')
vim.o["termguicolors"] = false

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

-- clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})


-- PLUGINS --

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
		-- add plugins
		'tpope/vim-fugitive',
		'nvim-treesitter/nvim-treesitter',
                build = ":TSUpdate",
		'nvim-lualine/lualine.nvim',
		"xzbdmw/colorful-menu.nvim",
		'davidgranstrom/scnvim',
                'saghen/blink.cmp',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
		},
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
            version = '1.*',
            completion = {
                menu = {
                    border = 'single',
                    auto_show = false,
                },
                documentation = {window ={border = 'single' }},
            },
            fuzzy = { implementation = 'rust' },
            ghost_text = { enabled = true },
            keymap = {
                preset = 'default',
                ['<C-c>'] = {'show'},
            },
        }

	require'nvim-treesitter.configs'.setup {
		ensure_installed = { "asm", "c", "cpp", "lua", "vim", "vimdoc",  "markdown", "markdown_inline", "swift", "rust", "zig" },
		sync_install = false,
		auto_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	}
        vim.lsp.enable('treesitter')

        --vim.cmd[[set completeopt+=menuone,noselect,popup]]
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('my.lsp', {}),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                if client:supports_method('textDocument/implementation') then
                    vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gs', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
                end
                if client:supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                        end,
                    })
                end
            end,
        })

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
        }
        vim.g.scnvim_postwin_syntax_hl = 1

	-- transparent background
	vim.cmd [[
	highlight Normal guibg=none
	highlight NonText guibg=none
	highlight Normal ctermbg=none
	highlight NonText ctermbg=none
	]]

        vim.cmd[[:highlight Pmenu guibg=#000000 cterm=NONE term=NONE]] 

	-- keymaps
	vim.g.mapleader = " "
	vim.g.maplocalleader = "\\"

