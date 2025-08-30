local status_ok, snacks = pcall(require, "snacks")
if not status_ok then
  return
end

snacks.setup({
  terminal = {
    win = {
      style = "terminal",
      position = "float",
      width = 0.8,
      height = 0.7,
      border = "rounded",
      backdrop = true
    },
    interactive = true,
    auto_insert = true,
    start_insert = true,
    auto_close = false,
    shell = vim.o.shell,
  },
  notifier = {},
  win = {},
})
