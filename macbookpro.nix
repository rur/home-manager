{ config, pkgs, ... }:

{
  home.username = "ruaidhridevery";
  home.homeDirectory = "/Users/ruaidhridevery";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  imports = [
    ./packages.nix
    ./git.nix
    ./vim.nix
    ./tmux.nix
    ./zsh.nix
    ./rest.nix
  ];
}
