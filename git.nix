{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;
    includes = [{ path = ./git/.gitconfig; }];
  };
}
