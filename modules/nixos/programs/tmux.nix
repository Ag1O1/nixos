{pkgs, ...}: {
  environment.systemPackages = [pkgs.tmux];

  hj.xdg.config.files."tmux/tmux.conf".text = ''
    set -g base-index 1
    set -g escape-time 0
    set -g prefix C-Space
    set -g status-keys vi
    set -g mode-keys vi

    bind -n M-h previous-window
    bind -n M-l next-window
  '';
}
