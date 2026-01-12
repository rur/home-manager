{ config, pkgs, pkgs-unstable, ... }:

let
  codeFolders = [
    "${config.home.homeDirectory}/code"
  ];
in {

  home.username = "ruaidhridevery";
  home.homeDirectory = "/home/ruaidhridevery";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    CODE_PATH = builtins.concatStringsSep ":" codeFolders;
  };

  # Nix garbage collection systemd service
  systemd.user.services.nix-gc = {
    Unit = {
      Description = "Nix garbage collection";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.nix}/bin/nix-collect-garbage -d";
    };
  };

  systemd.user.timers.nix-gc = {
    Unit = {
      Description = "Run nix garbage collection weekly";
    };
    Timer = {
      OnCalendar = "Sun *-*-* 03:00:00";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
  
  # unstable packages
  home.packages = with pkgs-unstable; [claude-code];

  imports = [
    ./packages.nix
    ./git.nix
    ./vim.nix
    ./tmux.nix
    ./bash.nix
    ./rest.nix
  ];
}
