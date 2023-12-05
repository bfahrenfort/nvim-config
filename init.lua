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
    virtual_text = false,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          "lua",
          "cpp",
          "rust",
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
    mappings = function(maps)
      local bufnr = vim.api.nvim_get_current_buf()
      local def_opts = { noremap = true, silent = true, buffer = bufnr }
      if vim.bo.filetype == "rust" then
        local rt = require "rust-tools"
        maps.n["<leader>hr"] = { "<cmd>RustRun<cr>", desc = "Run project", def_opts }
        maps.n["<leader>hR"] = { "<cmd>RustRunnables<cr>", desc = "Select runnable", def_opts }
        maps.n["<leader>hh"] = { rt.hover_actions.hover_actions, def_opts }
        maps.n["<leader>hc"] = { rt.open_cargo_toml.open_cargo_toml, def_opts }
        maps.n["<leader>ha"] = { rt.code_action_group.code_action_group, def_opts }
      end
      return maps
    end,
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

    config = {
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy", -- Doesn't work :/
            },
            checkOnSave = true,
            cachePriming = {
              enable = false,
            },
          },
        },
        on_attach = function(_, bufnr)
          local rt = require "rust-tools"
          local wk = require "which-key"
          wk.register({
            h = {
              name = "Rust commands",
              r = { "<cmd>RustRun<cr>", "Run project" },
              R = { "<cmd>RustRunnables<cr>", "Select runnable" },
              -- c = { ht.project.open_project_file, "Open yaml/cabal" },
              -- h = ,
              -- a = ,
            },
          }, { prefix = "<leader>", buffer = bufnr })
          -- maps.n["<leader>hr"] = { "<cmd>RustRun<cr>", desc = "Run project", def_opts }
          -- maps.n["<leader>hR"] = { "<cmd>RustRunnables<cr>", desc = "Select runnable", def_opts }
          -- maps.n["<leader>hh"] = { rt.hover_actions.hover_actions, def_opts }
          -- maps.n["<leader>hc"] = { rt.open_cargo_toml.open_cargo_toml, def_opts }
          -- maps.n["<leader>ha"] = { rt.code_action_group.code_action_group, def_opts }
        end,
      },
      clangd = {
        capabilities = { offsetEncoding = { "utf-16" } },
      },
      volar = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        init_options = {
          typescript = {
            tsdk = "/usr/local/lib/node_modules/typescript/lib/",
          },
        },
      },
      hls = {
        capabilities = function(opts)
          local lsr = require "lsp-selection-range"
          return lsr.update_capabilities(opts)
        end,
      },
    },
    setup_handlers = {
      -- add custom handler
      rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end,
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
    -- vim.api.nvim_create_autocmd("filereadpost", { command = "cd %:h" })
    -- vim.api.nvim_create_autocmd("BufReadPost", { command = "cd %:h" })

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
