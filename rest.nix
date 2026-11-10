{ pkgs, ... }: {

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = {
    ".inputrc".source = ./inputrc;
  };
}
