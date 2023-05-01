{ config, pkgs, ... }:

{
  home.username = "ruaidhridevery";
  home.homeDirectory = "/home/ruaidhridevery";

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    jq
    ripgrep
    htop
    fortune
    delta
    tree
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    __RD_HM_UPDATE_APPLIED = "123";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    tmux = {
      enable = true;
    };

    bash = {
      enable = true;
      profileExtra = ''
        eval "$(ssh-agent -s)"
      '';
      shellAliases = {
        ll = "ls -al";
        nv = "nvim";
      };
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      includes = [
        { path = ./git/.gitconfig; }
      ];
    };

    neovim = {
      enable = true;
      extraConfig = ''
        colorscheme gruvbox
        let g:context_nvim_no_redraw = 1
        set mouse=a
        set number
        set termguicolors
      '';
      plugins = with pkgs.vimPlugins;
        [
          editorconfig-vim
          gruvbox-community
          vim-airline
          vim-nix
        ]; # Only loaded if programs.neovim.extraConfig is set
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
