--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

  -- Configure AstroNvim updates
  updater = {
    -- remote = "upstream", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "v3.*", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme (look lower down you doofus)
  colorscheme = "catppuccin-macchiato",

  -- Add highlight groups in any theme
  highlights = {
    -- init = { -- this table overrides highlights in all themes
    --   Normal = { bg = "#000000" },
    --
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
  },

  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      -- set to true or false etc.
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      colorcolumn = "81",
      shiftwidth = 2,
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = false, -- sets vim.opt.wrap
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
      heirline_bufferline = true, -- enable new heirline based bufferline (requires :PackerSync after changing)
    },
  },

  -- Set dashboard header
  header = {
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
  },

  -- Default theme configuration
  default_theme = {
    -- Modify the color palette for the default theme
    colors = {
      -- fg = "#abb2bf",
      -- bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      -- New approach instead of diagnostic_style
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
          "lua",
          --          "cpp",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    server_registration = function(server, opts)
      if server == "clangd" then
        require("clangd_extensions").setup {
          server = opts,
        }
      else
        require("lspconfig")[server].setup(opts)
      end
    end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- FIXED moved to polish
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemaStore = {
      --         -- You must disable built-in schemaStore support if you want to use
      --         -- this plugin and its advanced options like `ignore`.
      --         enable = false,
      --         -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
      --         url = "",
      --       },
      --       schemas = require('schemastore').yaml.schemas(),
      --     },
      --   },
      -- },
      -- jsonls = {
      --   settings = {
      --     json = {
      --       schemas = require('schemastore').json.schemas(),
      --       validate = { enable = true },
      --     },
      --   },
      -- },
      --      clangd = {
      --        capabilities = {
      --          offsetEncoding = "utf-8", -- Peter, don't turn me into a permanent error!
      --        },
      --      },
    },
  },

  mappings = {
    n = {
      ["<leader>T"] = { name = "+Coding Commands" },
      ["<leader>m"] = { name = "+Markdown Commands" },
      -- mappings seen under group name "Buffer"
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      ["<leader>bh"] = { "<cmd>bprev<cr>", desc = "Previous buffer" },
      ["H"] = { "<cmd>bprev<cr>", desc = "Previous buffer" },
      ["<leader>bl"] = { "<cmd>bnext<cr>", desc = "Next buffer" },
      ["L"] = { "<cmd>bnext<cr>", desc = "Next buffer" },

      -- Markdown stuff
      ["<leader>mm"] = { "<cmd>MarkdownPreview<cr>", desc = "Start Markdown Preview" },
      ["<leader>mo"] = {
        "<cmd>lua require('marp.nvim').ServerStart()<cr><cmd>!Start-Process \"http://localhost:8080/%\"<cr><cr>",
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
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- Configure plugins
  -- READ THE DOCS YOU IDIOT https://github.com/folke/lazy.nvim#-plugin-spec
  plugins = {
    -- You can disable default plugins as follows:
    -- ["goolord/alpha-nvim"] = { disable = true },
    { "b0o/schemastore.nvim" },
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "hrsh7th/cmp-nvim-lua" },
    {
      "tamago324/cmp-zsh",
      opts = {
        zshrc = true,
        filetypes = { "zsh", "zshrc", "zshenv", "zprofile" },
      },
    },
    { "andweeb/presence.nvim" },
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
      "iamcco/markdown-preview.nvim",
      build = "cd app && npm install",
      init = function() vim.g.mkdp_filetypes = { "markdown" } end,
      ft = { "markdown" },
    },
    {
      "aca/marp.nvim",
    },

    -- OVERRRIDES for default plugins

    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
      }

      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format {
          filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            if vim.bo.filetype == "lua" then return client.name == "lua_ls" end
            if vim.bo.filetype == "cpp" then return client.name == "clangd" end
            return true
          end,
          bufnr = bufnr,
        }
      end

      -- if you want to set up formatting on save, you can use this as a callback
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      -- set up null-ls's on_attach function
      config.on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function() lsp_formatting(bufnr) end,
          })
        end
      end
      return config -- return final config table
    end,

    { -- override nvim-cmp plugin
      "hrsh7th/nvim-cmp",
      dependencies = { "cmp-zsh", "cmp-nvim-lua" },
      -- override the options table that is used in the `require("cmp").setup()` call
      opts = function(_, opts)
        -- opts parameter is the default options table
        -- the function is lazy loaded so cmp is able to be required
        local cmp = require "cmp"
        local luasnip = require "luasnip"

        -- sources
        opts.sources = cmp.config.sources {
          { name = "zsh", priority = 1000 },
          { name = "nvim_lua", priority = 1000 },
          { name = "nvim_lsp", priority = 999 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }

        -- Keybind nonsense
        local has_words_before = function()
          unpack = unpack or table.unpack
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
        end

        -- modify the mapping part of the table
        -- opts.mapping["<C-x>"] = cmp.madpping.select_next_item()
        opts.mapping["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
          else
            fallback()
          end
        end, { "i", "s" })
        opts.mapping["<Esc>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.abort()
          else
            fallback()
          end
        end, { "i", "s" })
        opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() and not cmp.visible() then
            luasnip.expand_or_jump()
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" })
        opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and not luasnip.jumpable(-1) then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" })

        return opts
      end,
    },
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require "astronvim.utils.status"
        opts.statusline = {
          -- default highlight for the entire statusline
          hl = { fg = "fg", bg = "bg" },
          -- each element following is a component in astronvim.utils.status module

          -- add the vim mode component
          status.component.mode {
            -- enable mode text with padding as well as an icon before it
            mode_text = { icon = { kind = "VimIcon", padding = { right = 1, left = 1 } } },
            -- surround the component with a separators
            surround = {
              -- it's a left element, so use the left separator
              separator = "left",
              -- set the color of the surrounding based on the current mode using astronvim.utils.status module
              color = function() return { main = status.hl.mode_bg(), right = "blank_bg" } end,
            },
          },
          -- we want an empty space here so we can use the component builder to make a new section with just an empty string
          status.component.builder {
            { provider = "" },
            -- define the surrounding separator and colors to be used inside of the component
            -- and the color to the right of the separated out section
            surround = { separator = "left", color = { main = "blank_bg", right = "file_info_bg" } },
          },
          -- add a section for the currently opened file information
          status.component.file_info {
            -- enable the file_icon and disable the highlighting based on filetype
            file_icon = { padding = { left = 0 } },
            filename = { fallback = "Empty" },
            -- add padding
            padding = { right = 1 },
            -- define the section separator
            surround = { separator = "left", condition = false },
          },
          -- add a component for the current git branch if it exists and use no separator for the sections
          status.component.git_branch { surround = { separator = "none" } },
          -- add a component for the current git diff if it exists and use no separator for the sections
          status.component.git_diff { padding = { left = 1 }, surround = { separator = "none" } },
          -- fill the rest of the statusline
          -- the elements after this will appear in the middle of the statusline
          status.component.fill(),
          -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
          status.component.lsp { lsp_client_names = false, surround = { separator = "none", color = "bg" } },
          -- fill the rest of the statusline
          -- the elements after this will appear on the right of the statusline
          status.component.fill(),
          -- add a component for the current diagnostics if it exists and use the right separator for the section
          status.component.diagnostics { surround = { separator = "right" } },
          -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
          status.component.lsp { lsp_progress = false, surround = { separator = "right" } },
          -- NvChad has some nice icons to go along with information, so we can create a parent component to do this
          -- all of the children of this table will be treated together as a single component
          {
            -- define a simple component where the provider is just a folder icon
            status.component.builder {
              -- astronvim.get_icon gets the user interface icon for a closed folder with a space after it
              { provider = require("astronvim.utils").get_icon "FolderClosed" },
              -- add padding after icon
              padding = { right = 1 },
              -- set the foreground color to be used for the icon
              hl = { fg = "bg" },
              -- use the right separator and define the background color
              surround = { separator = "right", color = "folder_icon_bg" },
            },
            -- add a file information component and only show the current working directory name
            status.component.file_info {
              -- we only want filename to be used and we can change the fname
              -- function to get the current working directory name
              filename = { fname = function(nr) return vim.fn.getcwd(nr) end, padding = { left = 1 } },
              -- disable all other elements of the file_info component
              file_icon = false,
              file_modified = false,
              file_read_only = false,
              -- use no separator for this part but define a background color
              surround = { separator = "none", color = "file_info_bg", condition = false },
            },
          },
          -- the final component of the NvChad statusline is the navigation section
          -- this is very similar to the previous current working directory section with the icon
          { -- make nav section with icon border
            -- define a custom component with just a file icon
            status.component.builder {
              { provider = require("astronvim.utils").get_icon "ScrollText" },
              -- add padding after icon
              padding = { right = 1 },
              -- set the icon foreground
              hl = { fg = "bg" },
              -- use the right separator and define the background color
              -- as well as the color to the left of the separator
              surround = { separator = "right", color = { main = "nav_icon_bg", left = "file_info_bg" } },
            },
            -- add a navigation component and just display the percentage of progress in the file
            status.component.nav {
              -- add some padding for the percentage provider
              percentage = { padding = { right = 1 } },
              -- disable all other providers
              ruler = false,
              scrollbar = false,
              -- use no separator and define the background color
              surround = { separator = "none", color = "file_info_bg" },
            },
          },
        }

        return opts
      end,
    },
    --  telescope = {
    --    extensions = { "flutter" },
    --  },
    treesitter = { -- overrides `require("treesitter").setup(...)`
      ensure_installed = { "lua" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      -- ensure_installed = { "prettier", "stylua" },
    },
    ["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
      -- ensure_installed = { "python" },
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      -- javascript = { "javascriptreact" },
    },
    -- Configure luasnip loaders (vscode, lua, and/or snipmate)
    vscode = {
      -- Add paths for including more VS Code style snippets in luasnip
      paths = {
        "/usr/share/codium/resources/app/extensions/typescript-basics/snippets/typescript.code-snippets",
        "/usr/share/codium/resources/app/extensions/java/snippets/java.code-snippets",
        "/usr/share/codium/resources/app/extensions/cpp/snippets/c.code-snippets",
        "/usr/share/codium/resources/app/extensions/cpp/snippets/cpp.code-snippets",
        "/usr/share/codium/resources/app/extensions/javascript/snippets/javascript.code-snippets",
        "/usr/share/codium/resources/app/extensions/markdown-basics/snippets/markdown.code-snippets",
        "/usr/share/codium/resources/app/extensions/html/snippets/html.code-snippets",
        "~/.vscode-oss/extensions/jeffersonqin.latex-snippets-jeff-1.2.3-universal/snippets/latex.json",
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Customize Heirline options
  heirline = {
    -- define the separators between each section
    separators = {
      left = { "", " " }, -- separator for the left side of the statusline
      right = { " ", "" }, -- separator for the right side of the statusline
      -- tab = { "", "" },
    },
    -- add new colors that can be used by heirline
    colors = function(hl)
      local get_hlgroup = require("astronvim.utils").get_hlgroup
      -- use helper function to get highlight group properties
      local comment_fg = get_hlgroup("Comment").fg
      hl.git_branch_fg = comment_fg
      -- hl.git_added = comment_fg
      -- hl.git_changed = comment_fg
      -- hl.git_removed = comment_fg
      hl.blank_bg = get_hlgroup("Folded").fg
      hl.file_info_bg = get_hlgroup("Visual").bg
      hl.nav_icon_bg = get_hlgroup("String").fg
      hl.nav_fg = hl.nav_icon_bg
      hl.folder_icon_bg = get_hlgroup("Error").fg
      return hl
    end,
    attributes = {
      mode = { bold = true },
    },
    icon_highlights = {
      file_icon = {
        statusline = false,
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- vim.lsp.set_log_level("debug")

    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })

    -- On buffer open, change cwd
    vim.api.nvim_create_autocmd("FileReadPost", { command = "cd %:h" })
    vim.api.nvim_create_autocmd("BufReadPost", { command = "cd %:h" })
    -- vim.cmd("Neotree")
    -- vim.cmd('call timer_start(1, { -> execute( "wincmd l") })')

    vim.diagnostic.config { update_in_insert = false }
    vim.opt.shell = "zsh"
    vim.opt.shellcmdflag = "-c"

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    vim.g.do_filetype_lua = 1
    vim.g.did_load_filetypes = false
    vim.g.dart_format_on_save = 1
    -- vim.o.autochdir = true

    -- Had to do it to em
    vim.fn.setenv("NVIM_CONFIG", "~/.config/nvim/lua/user/init.lua")
  end,
}

return config
