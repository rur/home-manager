# Telescope fuzzy finder configuration
{
  programs.nixvim.plugins.telescope = {
    enable = true;

    extensions = {
      fzf-native = {
        enable = true;
      };
    };

    settings = {
      defaults = {
        mappings = {
          i = {
            "<C-j>" = {
              __raw = "require('telescope.actions').move_selection_next";
            };
            "<C-k>" = {
              __raw = "require('telescope.actions').move_selection_previous";
            };
          };
        };
      };
    };
  };
}
