{ pkgs, ... }: {

  home.sessionVariables = {
    EDITOR = "nvim";
    __RD_HM_UPDATE_APPLIED = "789";
  };

  home.file = {
    ".inputrc".source = ./inputrc;
  };
}
