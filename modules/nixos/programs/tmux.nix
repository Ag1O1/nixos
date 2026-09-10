{pkgs, ...}: {
  environment.systemPackages = [pkgs.tmux];

  # Also convert to hjem
  /*
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    shortcut = "Space";
    keyMode = "vi";
    plugins = [pkgs.tmuxPlugins.resurrect];

    extraConfig = ''
      bind -n M-h previous-window
      bind -n M-l next-window
    '';
  };
  */
}
