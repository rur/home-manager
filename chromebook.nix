{ config, pkgs, ... }:

let
  codeFolders = [
    "${config.home.homeDirectory}/code"
  ];
in {

  home.username = "ruaidhridevery";
  home.homeDirectory = "/home/ruaidhridevery";
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
    ./bash.nix
    ./rest.nix
  ];
}
