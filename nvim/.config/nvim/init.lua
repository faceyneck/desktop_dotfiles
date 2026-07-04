require("config.lazy")
-- Enable native treesitter highlighting on startup
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

