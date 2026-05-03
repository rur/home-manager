# Language-specific plugins and configurations
{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      # Go development
      vim-go

      # Go debugger
      (pkgs.vimUtils.buildVimPlugin {
        name = "vim-delve";
        src = pkgs.fetchFromGitHub {
          owner = "sebdah";
          repo = "vim-delve";
          rev = "41d6ad294fb6dd5090f5f938318fc4ed73b6e1ea";
          sha256 = "sha256-wMDTMMvtjkPaWtlV6SWlQ5B7YVsJ4gjPZKPactW8HAE=";
        };
      })

      # Nix language support
      vim-nix

      # EditorConfig support
      editorconfig-nvim
    ];

    extraConfigLua = ''
      -- Go settings for vim-go
      vim.g.go_metalinter_linter = {'golangci-lint'}
      vim.g.go_metalinter_fast = 1
    '';
  };
}
