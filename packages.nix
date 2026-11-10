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
    graphviz
    htop
    jq
    nixfmt
    tree
    pstree
    watch
    fswatch
    wget
    fd
    gh
    imagemagick
  ];
}
