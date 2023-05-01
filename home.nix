{ config, pkgs, ... }:

{
  home.username = "ruaidhridevery";
  home.homeDirectory = "/home/ruaidhridevery";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  imports = [
    ./packages.nix
    ./git.nix
    ./vim.nix
    ./tmux.nix
    ./rest.nix
  ];
}
