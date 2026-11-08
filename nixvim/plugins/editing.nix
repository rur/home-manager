# Editing enhancement plugins
{
  programs.nixvim.plugins = {
    # Commenting
    comment.enable = true;

    # Auto-pairing brackets
    nvim-autopairs = {
      enable = true;
    };

    # Distraction-free writing
    zen-mode.enable = true;
  };
}
