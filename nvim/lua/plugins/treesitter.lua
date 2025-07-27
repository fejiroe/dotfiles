return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function() 
        require'nvim-treesitter.configs'.setup ({
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
