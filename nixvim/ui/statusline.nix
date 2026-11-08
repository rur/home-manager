# Statusline configuration with simple separators
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "nord";
        # Use simple text separators instead of icon glyphs
        section_separators = {
          left = "";
          right = "";
        };
        component_separators = {
          left = "|";
          right = "|";
        };
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" "diff" "diagnostics" ];
        lualine_c = [ "filename" ];
        lualine_x = [ "encoding" "fileformat" "filetype" ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
    };
  };
}
