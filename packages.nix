{ pkgs, ... }: {
  home.packages = [
    pkgs.jq
    pkgs.ripgrep
    pkgs.htop
    pkgs.fortune
    pkgs.delta
    pkgs.tree
  ];
}
