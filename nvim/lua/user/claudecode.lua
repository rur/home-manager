local status_ok, claudecode = pcall(require, "claudecode")
if not status_ok then
  return
end

claudecode.setup({
  -- Optional configuration
  -- The plugin should work out of the box with default settings
  -- when claude-code is available in PATH
})