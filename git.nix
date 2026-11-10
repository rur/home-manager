{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;

    settings = {
      user = {
        name = "Ruaidhri Devery";
        email = "deveryr2@gmail.com";
      };

      alias = {
        c = "commit -v";
        ca = "commit --amend";
        co = "checkout";
        cob = "checkout -b";
        s = "status";
        br = "branch";
        bra = "branch -alvv";
        d = "diff";
        dd = "diff --cached";
        l = "log --oneline --graph";
      };

      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      pull.ff = "only";
    };
  };

  # Sets core.pager and interactive.diffFilter to delta automatically.
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      navigate = true; # use n and N to move between diff sections
      light = false; # set to true in a terminal with a light background
    };
  };
}
