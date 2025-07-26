return {
    'nvim-treesitter/nvim-treesitter',
    config = function() 
        require'nvim-treesitter.configs'.setup ({
            build = ":TSUpdate",
            ensure_installed = { "asm", "bash", "c", "cpp", "lua", "vim", "vimdoc",  "markdown", "markdown_inline", "swift", "rust", "zig" },
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end
}
