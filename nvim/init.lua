require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.cmds")


--[[
vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})

  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- empty setup using defaults
--require("nvim-tree").setup()

  -- OR setup with a config

  ---@type nvim_tree.config
  local config = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  }
  require("nvim-tree").setup(config)
]]--
