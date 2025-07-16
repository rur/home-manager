local status_ok, claudecode = pcall(require, "claudecode")
if not status_ok then
  vim.notify("lua/user/claudecode.lua: failed to require 'claudecode'")
  return
end

claudecode.setup({
  terminal = {
    provider = "snacks",
    split_side = "right",
    split_width_percentage = 0.35,
    auto_close = false
  }
})