-- READ THE DOCS YOU IDIOT https://github.com/folke/lazy.nvim#-plugin-spec
---@type LazySpec
return {
  -- Snippets etc
  { "b0o/schemastore.nvim" },

  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "hrsh7th/cmp-nvim-lua" },
  {
    "tamago324/cmp-zsh",
    opts = {
      zshrc = true,
      filetypes = { "zsh", "zshrc", "zshenv", "zprofile" },
    },
  },

  -- Misc
  {
    "lambdalisue/suda.vim",
    lazy = false,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "andweeb/presence.nvim",
    lazy = false,
    opts = {
      buttons = false,
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    name = "rainbow-delimiters",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          commonlisp = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        blacklist = { "c", "cpp" },
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
    opts = {
      integrations = {
        notify = true,
        mason = true,
        which_key = true,
      },
      term_colors = true,
    },
    dependencies = { "rainbow-delimiters" },
  },
  {
    "camilledejoye/nvim-lsp-selection-range",
    -- config = function()
    --   local nvim_lsp = require "lspconfig"
    --   local lsp_selection_range = require "lsp-selection-range"
    --   return {
    --     capabilities = lsp_selection_range.update_capabilities(nvim_lsp.capabilities),
    --   }
    -- end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      "BufReadPre /home/b/Documents/Obsidian/Notes/**.md",
      "BufNewFile /home/b/Documents/Obsidian/Notes/**.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Documents/Obsidian/Notes",
        },
      },

      -- see below for full list of options 👇
    },
  },

  -- Languages & filetypes
  {
    "esensar/nvim-dev-container",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      attach_mounts = {
        neovim_config = {
          -- enables mounting local config to /root/.config/nvim in container
          enabled = false,
          -- makes mount readonly in container
          options = { "readonly" },
          custom_mounts = {
            -- "type=bind,source=~/.config/nvim,target=/home/root/.config/nvim",
          },
        },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  {
    "aca/marp.nvim",
    ft = { "markdown" },
  },
  {
    "simrat39/rust-tools.nvim",
    opts = {
      hover_actions = {
        auto_focus = true,
      },
    },
    config = function(_, opts)
      local rt = require "rust-tools"
      local wk = require "which-key"

      wk.register({
        h = {
          name = "Rust commands",
          r = { "<cmd>RustRun<cr>", "Run" },
          R = { "<cmd>RustRunnables<cr>", "Select runnable" },
          h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
          c = { "<cmd>RustOpenCargo<cr>", "Open Cargo.toml" },
          a = { "<cmd>RustCodeAction<cr>", "Code Actions" },
        },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lsp-selection-range",
    },
    version = "^2", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function(_, opts)
      local ht = require "haskell-tools"
      local wk = require "which-key"
      local bufnr = vim.api.nvim_get_current_buf()

      wk.register({
        h = {
          name = "Haskell commands",
          s = { ht.hoogle.hoogle_signature, "Hoogle Signature under Caret" },
          r = { ht.repl.toggle, "Toggle REPL for current package" },
          c = { ht.project.open_project_file, "Open yaml/cabal" },
        },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "p00f/clangd_extensions.nvim", -- install lsp plugin
    init = function(_)
      -- load clangd extensions when clangd attaches
      local augroup = vim.api.nvim_create_augroup("clangd_extensions", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        desc = "Load clangd_extensions with clangd",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
            require "clangd_extensions"
            -- add more `clangd` setup here as needed such as loading autocmds
            vim.api.nvim_del_augroup_by_id(augroup) -- delete auto command since it only needs to happen once
          end
        end,
      })
    end,
  },
  -- == Examples of Adding Plugins ==

  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
