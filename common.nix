# Shared configuration imported by every machine.
# Machine-specific files set username/homeDirectory and add extra
# packages, then import this.
{
  config,
  lib,
  ...
}:
{
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  # Default development path; machines can override to add more folders.
  home.sessionVariables.CODE_PATH = lib.mkDefault "${config.home.homeDirectory}/code";

  imports = [
    ./packages.nix
    ./claude.nix
    ./git.nix
    ./nixvim.nix
    ./tmux.nix
    ./rest.nix
  ];
}
