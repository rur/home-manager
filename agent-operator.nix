{ ... }: {
  home.username = "operator";
  home.homeDirectory = "/home/operator";

  imports = [
    ./common.nix
    ./bash.nix
  ];
}
