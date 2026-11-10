{ pkgs, ... }: {
  home.username = "ruaidhridevery";
  home.homeDirectory = "/home/ruaidhridevery";

  home.packages = [ pkgs.tailscale ];

  imports = [
    ./common.nix
    ./bash.nix
  ];
}
