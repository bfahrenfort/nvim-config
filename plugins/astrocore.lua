-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = false, -- default true
      underline = true,
      update_in_insert = false,
    },
    mappings = {
      n = {
        -- Disables
        ["<C-f>"] = false,
        ["<Leader>h"] = false,

        -- Oil over Neotree
        ["<Leader>e"] = { require("oil").toggle_float },

        -- Groups
        ["<Leader>T"] = { desc = "Coding Commands" },
        -- ["<Leader>h"] = { false, desc = "Language Commands" },
        ["<Leader>m"] = { desc = "Markdown Commands" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<Leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
        ["<Leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
        ["<Leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
        ["<Leader>bh"] = { "<cmd>bprev<cr>", desc = "Previous buffer" },
        ["<Leader>bl"] = { "<cmd>bnext<cr>", desc = "Next buffer" },
        L = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        J = {
          "<PageDown>",
        },
        K = {
          "<PageUp>",
        },

        -- Markdown stuff
        ["<Leader>mm"] = { "<cmd>MarkdownPreview<cr>", desc = "Start Markdown Preview" },
        ["<Leader>mo"] = {
          "<cmd>lua require('marp.nvim').ServerStart()<cr>", --<cmd>!gnome-open \"http://localhost:8080/%\"<cr><cr>",
          desc = "Start Marp server",
        },
        ["<Leader>mc"] = { "<cmd>lua require('marp.nvim').ServerStop()<cr>", desc = "Stop Marp server" },

        ["<C-w>"] = { -- IMPORTANT! WINCMD DOES NOT WORK FROM THIS NOW.
          "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>",
          desc = "close the current buffer, and open a new one if it was the last one",
        },
        -- quick save
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command

        -- Trouble
        ["<Leader>do"] = { "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble" }, -- change description but the same command

        -- Tmux for some reason
        ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>" },

        ["<Leader>;"] = {
          function() return "A;<esc>" end,
          noremap = true,
          silent = true,
          expr = true,
          desc = "insert semicolon at end of line",
        },
      },
      i = {
        -- ["<Leader>;"] = {
        -- function() return vim.api.nvim_replace_termcodes("<esc>A;<esc>", true, true, true) end,
        --  noremap = true,
        --  silent = true,
        --  expr = true,
        --  desc = "insert semicolon at end of line",
        -- },
      },
      t = {
        ["<Esc>"] = { "<C-\\><C-n>", noremap = true },
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
    options = {
      opt = {
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        colorcolumn = "81",
        shiftwidth = 2,
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        shell = "zsh",
        shellcmdflag = "-c",
      },
      g = {
        suda_smart_edit = 1, -- Open root files auto-root
        vimtex_view_general_viewer = "okular",
        vimtex_view_general_options = "--unique file:@pdf#src:@line@tex",
        haskell_tools = {
          hls = {
            settings = {
              haskell = {
                plugin = {},
              },
            },
            -- capabilities = function(opts)
            --   local lsr = require "lsp-selection-range"
            --   local caps = lsr.update_capabilities(opts)
            --   return vim.list_extend(, { "textDocument/semanticTokens" })
            -- end,
            capabilities = { ["textDocument/semanticTokens"] = "full" },
          },
        },
      },
    },
    features = {
      autopairs = true,
      cmp = true,
      codelens = true, -- test
      diagnostics_mode = 3, -- no idea if this works bc documentation is wrong
      notifications = true,
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      highlighturl = true, -- highlight URLs at start
    },
    rooter = {
      autochdir = true,
    },
  },
}
