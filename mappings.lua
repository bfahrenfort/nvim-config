return {
  n = {
    -- Disables
    ["<C-f>"] = false,
    ["<leader>h"] = false,

    -- Groups
    ["<leader>T"] = { name = "Coding Commands" },
    ["<leader>m"] = { name = "Markdown Commands" },

    -- mappings seen under group name "Buffer"
    ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    ["<leader>bh"] = { "<cmd>bprev<cr>", desc = "Previous buffer" },
    ["<leader>bl"] = { "<cmd>bnext<cr>", desc = "Next buffer" },
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    J = {
      "<PageDown>",
    },
    K = {
      "<PageUp>",
    },

    -- Markdown stuff
    ["<leader>mm"] = { "<cmd>MarkdownPreview<cr>", desc = "Start Markdown Preview" },
    ["<leader>mo"] = {
      "<cmd>lua require('marp.nvim').ServerStart()<cr>", --<cmd>!gnome-open \"http://localhost:8080/%\"<cr><cr>",
      desc = "Start Marp server",
    },
    ["<leader>mc"] = { "<cmd>lua require('marp.nvim').ServerStop()<cr>", desc = "Stop Marp server" },

    ["<C-w>"] = { -- IMPORTANT! WINCMD DOES NOT WORK FROM THIS NOW.
      "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>",
      desc = "close the current buffer, and open a new one if it was the last one",
    },
    -- quick save
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command

    -- Trouble
    ["<leader>do"] = { "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" }, -- change description but the same command

    -- Tmux for some reason
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
