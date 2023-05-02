{ pkgs, ... }: {
  home.packages = with pkgs; [
    jq
    ripgrep
    htop
    fortune
    delta
    tree
    xclip
  ];
}
