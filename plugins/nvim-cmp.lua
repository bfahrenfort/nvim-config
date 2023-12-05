return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "cmp-zsh", "cmp-nvim-lua", "cmp-nvim-lsp" },
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
        { name = "buffer", priority = 750 },
        { name = "luasnip", priority = 500 },
        { name = "path", priority = 250 },
      }

      -- Keybind nonsense
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      -- modify the mapping part of the table

      -- My custom
      opts.mapping["<Up>"] = cmp.mapping(function(fallback)
        cmp.abort()
        fallback()
      end, { "i", "s" })
      opts.mapping["<Down>"] = cmp.mapping(function(fallback)
        cmp.abort()
        fallback()
      end, { "i", "s" })

      -- luasnip suggested
      -- icky
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" })
      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })
      opts.mapping["<Esc>"] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.abort()
        elseif cmp.visible() then
          cmp.abort()
          fallback()
        else
          fallback()
        end
      end, { "i" })

      -- Previous custom attempt: Uncomfy
      -- opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      -- if luasnip.jumpable() and not cmp.get_active_entry() then
      --   luasnip.jump()
      -- elseif cmp.visible() then
      --   cmp.select_next_item()
      -- elseif has_words_before() then
      --   cmp.complete()
      -- else
      --   fallback()
      -- end
      -- end, { "i", "s" })
      -- opts.mapping["<S-Enter>"] = cmp.mapping(function(fallback)
      -- if luasnip.jumpable(-1) then
      --   luasnip.jump(-1)
      -- else
      --   fallback()
      -- end
      -- end, { "i", "s" })
      -- opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
      -- if cmp.visible() and cmp.get_selected_entry() and not luasnip.jumpable(-1) then
      --   cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then
      --   luasnip.jump(-1)
      -- else
      --   fallback()
      -- end
      -- end, { "i", "s" })

      -- cmp suggested: doesn't work
      -- opts.mapping["<C-K>"] = cmp.mapping(function(fallback)
      --   if luasnip.expandable() then
      --     luasnip.expand()
      --   else
      --     fallback()
      --   end
      -- end, { "i" })
      -- opts.mapping["C-L"] = cmp.mapping(function(fallback)
      --   if luasnip.jumpable() then
      --     luasnip.jump(1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" })
      -- opts.mapping["C-J"] = cmp.mapping(function(fallback)
      --   if luasnip.jumpable(-1) then
      --     luasnip.jump(-1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" })
      -- opts.mapping["C-E"] = cmp.mapping(function(fallback)
      --   if luasnip.choice_active() then
      --     luasnip.change_choice(1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" })
      return opts
    end,
  },
}
