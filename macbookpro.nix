{ config, pkgs, ... }:

let
  codeFolders = [
    "${config.home.homeDirectory}/code"
    "${config.home.homeDirectory}/learning"
  ];
in {
  home.username = "ruaidhridevery";
  home.homeDirectory = "/Users/ruaidhridevery";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  
  home.sessionVariables = {
    CODE_SEARCH_LIST = builtins.concatStringsSep "," codeFolders;
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
