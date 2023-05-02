{ pkgs, ... }: {

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    secureSocket = false;
    baseIndex = 1;
    prefix = "C-Space";

    plugins = with pkgs.tmuxPlugins; [
      yank
      better-mouse-mode
      sensible
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
