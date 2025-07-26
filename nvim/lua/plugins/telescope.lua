return {
	'nvim-telescope/telescope.nvim',
	config = function ()
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
		vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', {bg = 'none' })
		vim.api.nvim_set_hl(0, 'TelescopePromptPromptTitle', {bg = 'none' })
		vim.api.nvim_set_hl(0, 'TelescopeSelection', {bg = 'none' })
		vim.api.nvim_set_hl(0, 'TelescopeMatching', {bg = 'none' })
		vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', {bg = 'none' })
		vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', {bg = 'none' })


	end
}
