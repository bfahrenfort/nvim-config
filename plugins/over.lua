-- Overrides for default plugins

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
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      -- local luasnip = require "luasnip"
      -- luasnip.filetype_extend("javascript", { "javascriptreact" })

      require("luasnip.loaders.from_vscode").lazy_load {
        paths = {
          "~/.vscode-oss/extensions/rust-lang.rust-0.7.8-universal/snippets/rust.json",
          -- "/usr/share/codium/resources/app/extensions/typescript-basics/snippets/typescript.code-snippets",
          -- "/usr/share/codium/resources/app/extensions/java/snippets/java.code-snippets",
          -- "/usr/share/codium/resources/app/extensions/cpp/snippets/c.code-snippets",
          -- "/usr/share/codium/resources/app/extensions/cpp/snippets/cpp.code-snippets",
          -- "/usr/share/codium/resources/app/extensions/javascript/snippets/javascript.code-snippets",
          -- "/usr/share/codium/resources/app/extensions/markdown-basics/snippets/markdown.code-snippets",
          -- "/usr/share/codium/resources/app/extensions/html/snippets/html.code-snippets",
          -- "~/.vscode-oss/extensions/jeffersonqin.latex-snippets-jeff-1.2.3-universal/snippets/latex.json",
        },
      }
    end,
  },
}
