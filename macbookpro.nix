{ config, pkgs, pkgs-unstable, ... }:

let
  codeFolders = [
    "${config.home.homeDirectory}/code"
    "${config.home.homeDirectory}/learning"
  ];
in {
  home.username = "ruaidhridevery";
  home.homeDirectory = "/Users/ruaidhridevery";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  
  home.sessionVariables = {
    CODE_SEARCH_LIST = builtins.concatStringsSep "," codeFolders;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # unstable packages
  home.packages = with pkgs-unstable; [claude-code];

  # Create symlink for claudecode.nvim plugin compatibility
  home.file.".local/bin/claude-code" = {
    source = "${pkgs-unstable.claude-code}/bin/claude";
  };

  imports = [
    ./packages.nix
    ./git.nix
    ./vim.nix
    ./tmux.nix
    ./zsh.nix
    ./rest.nix
  ];
}
