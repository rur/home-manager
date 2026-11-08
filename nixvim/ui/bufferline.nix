# Bufferline configuration with portable glyphs
{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        diagnostics = "nvim_lsp";
        separator_style = "thin";

        # Use simple text-based glyphs instead of icon fonts
        # These match the legacy configuration from nvim/lua/user/bufferline.lua
        indicator = {
          style = "icon";
          icon = "▎";  # Simple vertical bar
        };
        buffer_close_icon = "×";     # Simple X character
        modified_icon = "●";          # Simple dot
        close_icon = "×";             # Simple X character
        left_trunc_marker = "";       # Empty - no special glyph needed
        right_trunc_marker = "";      # Empty - no special glyph needed

        # Offset for file tree
        offsets = [
          {
            filetype = "NvimTree";
            text = "File Explorer";
            highlight = "Directory";
            text_align = "left";
          }
        ];
      };
    };
  };
}
