# Treesitter syntax highlighting and text objects
{
  programs.nixvim.plugins = {
    # Treesitter - modern syntax highlighting
    treesitter = {
      enable = true;
      nixGrammars = true;
      settings = {
        highlight = {
          enable = true;
        };
        indent = {
          enable = true;
        };
      };
    };

    # Treesitter text objects
    treesitter-textobjects = {
      enable = true;
    };
  };
}
