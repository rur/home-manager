local status_ok, snacks = pcall(require, "folke/snacks.nvim")
if not status_ok then
  return
end

snacks.setup {}
