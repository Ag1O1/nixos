{pkgs, ...}: {
  boot.plymouth = {
    enable = true;
    themePackages = [pkgs.adi1090x-plymouth-themes];
    theme = "deus_ex";
  };
}
