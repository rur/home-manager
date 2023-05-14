{ pkgs, ... }: {

  home.sessionVariables = {
    EDITOR = "nvim";
    __RD_HM_UPDATE_APPLIED = "789";
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "rg --files --hidden --follow";
    defaultOptions = [ "-m --bind ctrl-a:select-all,ctrl-d:deselect-all" ];
  };

  programs.bash = {
    enable = true;
    profileExtra = builtins.readFile ./bash/profile;
    initExtra = builtins.readFile ./bash/bashrc;
    logoutExtra = builtins.readFile ./bash/logout;
    historyControl = [ "ignorespace" "ignoredups" ];
    sessionVariables = {
      PROMPT_COMMAND = "echo";
      EDITOR = "nvim";
      SHELL = "${pkgs.bashInteractive}/bin/bash";
      BAT_THEME = "OneHalfDark";
    };
    shellAliases = {
      rm = "rm -i";
      mv = "mv -i";
      cp = "cp -i";
      grep = "grep --color=auto";
      sudo = "sudo ";
      nv = "nvim";
      fe = "find_and_edit"; # see .profile for function definition
    };
    shellOptions = [
      "cdspell"
      "checkwinsize"
      "cmdhist"
      "dotglob"
      "histappend"
      "nocaseglob"
    ];
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  home.file = {
    ".inputrc".source = ./inputrc;
  };
}
