# File tree configuration
# Using portable ASCII characters instead of icon fonts
{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;

    settings = {
      # Auto-update focused file
      update_focused_file = {
        enable = true;
        update_cwd = false;
      };

      # Disable dotfiles filter
      filters = {
        dotfiles = false;
      };

      # Renderer configuration with portable glyphs
      renderer = {
        root_folder_modifier = ":t";
        group_empty = true;
        icons = {
          show = {
            file = false;           # Disable file icons
            folder = true;          # Show folder indicators
            folder_arrow = true;    # Show folder arrows
            git = true;             # Show git status
          };
          glyphs = {
            # Default file/folder glyphs - using simple ASCII
            default = "";
            symlink = "➚";

            folder = {
              arrow_closed = "▹";
              arrow_open = "▾";
              default = "";
              open = "";
              empty = "∅";
              empty_open = "∅";
              symlink = "➚";
              symlink_open = "➚";
            };

            # Git status using simple text
            git = {
              unstaged = "u";
              staged = "s";
              unmerged = "m";
              renamed = "rnm";
              untracked = "??";
              deleted = "del";
              ignored = ".i";
            };
          };
        };
      };

      # Diagnostics with text-based icons
      diagnostics = {
        enable = true;
        show_on_dirs = true;
        icons = {
          hint = "h";
          info = "i";
          warning = "w";
          error = "e";
        };
      };

      # View settings
      view = {
        width = 30;
        side = "left";
      };
    };
  };

  # Explicitly disable web-devicons to avoid icon font dependency
  programs.nixvim.plugins.web-devicons.enable = false;
}
