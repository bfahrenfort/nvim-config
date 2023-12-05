return {
  {
    "kevinhwang91/nvim-ufo",
    opts = {
      provider_selector = function(filetype)
        if filetype == "haskell" then return { "treesitter", "indent" } end
        return nil -- use default
      end,
    },
  },

  --  telescope = {
  --    extensions = { "flutter" },
  --  },
  -- treesitter = { -- overrides `require("treesitter").setup(...)`
  --   ensure_installed = { "lua" },
  -- },
  -- -- use mason-lspconfig to configure LSP installations
  -- ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
  -- },
  -- -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  -- ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
  --   -- ensure_installed = { "prettier", "stylua" },
  -- },
  -- ["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
  --   -- ensure_installed = { "python" },
  -- },
}
