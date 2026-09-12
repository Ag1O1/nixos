{pkgs, ...}: {
  programs.plymouth = {
    enable = true;
    theme = pkgs.adi1090x-plymouth-themes;
    settings.Daemon.Theme = "deus_ex";
  };
}
