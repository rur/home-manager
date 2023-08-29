

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  command = "setlocal shiftwidth=6 tabstop=6"
})
