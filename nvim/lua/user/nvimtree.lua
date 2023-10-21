local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "➚",
        folder = {
          arrow_open = "▾",
          arrow_closed = "▹",
          default = "",
          open = "",
          empty = "∅",
          empty_open = "∅",
          symlink = "➚",
          symlink_open = "➚",
        },
        git = {
          unstaged = "u",
          staged = "s",
          unmerged = "m",
          renamed = "rnm",
          untracked = "??",
          deleted = "del",
          ignored = ".i",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "h",
      info = "i",
      warning = "w",
      error = "e",
    },
  },
  view = {
    width = 30,
    side = "left"
  },
}
