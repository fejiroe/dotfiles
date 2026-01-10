return {
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 90, -- width of the Zen window
                height = 1, -- height of the Zen window
                options = {
                },
            },
            plugins = {
                options = {
                    enabled = true,
                    laststatus = 0,
                },
                tmux = {enabled = true},
                gitsigns = {enabled = false},
            },
        }
    }
}
