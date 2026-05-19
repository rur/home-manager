{ config, pkgs, pkgs-unstable, ... }:

let
  codeFolders = [
    "${config.home.homeDirectory}/code"
  ];
in {

  home.username = "ruaidhridevery";
  home.homeDirectory = "/home/ruaidhridevery";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    CODE_PATH = builtins.concatStringsSep ":" codeFolders;
  };

  # unstable packages
  home.packages = [ 
    pkgs-unstable.claude-code
    pkgs.tailscale
  ];

  imports = [
    ./packages.nix
    ./git.nix
    ./nixvim.nix
    ./tmux.nix
    ./bash.nix
    ./rest.nix
  ];
}
