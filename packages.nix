{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    delta
    xclip
    bashInteractive
    bat
    comma
    coreutils
    gnugrep
    gnused
    htop
    jq
    nix-bash-completions
    nixfmt
    ripgrep
    tree
    watch
    fswatch
    wget
    fd
  ];
}
