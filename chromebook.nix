{ config, pkgs, ... }:

let
  codeFolders = [
    "${config.home.homeDirectory}/code"
  ];
in {

  home.username = "ruaidhridevery";
  home.homeDirectory = "/home/ruaidhridevery";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    CODE_PATH = builtins.concatStringsSep ":" codeFolders;
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
