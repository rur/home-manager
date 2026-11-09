{
  config,
  lib,
  pkgs,
  ...
}:

let
  codeFolders = [
    "${config.home.homeDirectory}/code"
    "${config.home.homeDirectory}/learning"
  ];
in
{
  home.username = "ruaidhridevery";
  home.homeDirectory = "/Users/ruaidhridevery";

  home.sessionVariables.CODE_PATH = lib.concatStringsSep ":" codeFolders;

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Nix garbage collection cron job
  launchd.agents.nix-gc = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.nix}/bin/nix-collect-garbage"
        "-d"
      ];
      StartCalendarInterval = [
        {
          Weekday = 0; # Sunday
          Hour = 3;
          Minute = 0;
        }
      ];
    };
  };

  # Create symlink for claudecode.nvim plugin compatibility
  home.file.".local/bin/claude-code" = {
    source = "${config.programs.claude-code.finalPackage}/bin/claude";
  };

  imports = [
    ./common.nix
    ./zsh.nix
  ];
}
