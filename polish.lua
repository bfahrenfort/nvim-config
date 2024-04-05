-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

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
vim.fn.setenv("NVIM_CONFIG", "~/.config/nvim/lua/init.lua")

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
