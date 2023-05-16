{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    delta
    xclip
    bat
    comma
    coreutils
    gnugrep
    gnused
    htop
    jq
    nixfmt
    ripgrep
    tree
    pstree
    watch
    fswatch
    wget
    fd
  ];
}
