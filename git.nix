{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    includes = [{ path = ./git/.gitconfig; }];
  };
}
