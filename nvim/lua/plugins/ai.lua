return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "openai_responses",
        },
        inlne = {
            adapter = "openai_responses"
        },
      },
      adapters = {
          http = {
        openai_responses = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "http://localhost:1234",
            },
          })
        end,
      },
  },
    })
  end,

  -- Optional keybindings
  vim.keymap.set({ "n", "v" }, "<leader>a", "", { desc = "AI" }),
  vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Open CodeCompanion Chat" }),
  vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "Inline CodeCompanion" }),
  vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" }),
}
