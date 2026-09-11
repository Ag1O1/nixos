{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.adw-gtk3

    #pkgs.dracula-icon-theme
    (pkgs.papirus-icon-theme.override {color = "yellow";})

    pkgs.bibata-cursors
    pkgs.nwg-look
    pkgs.xsettingsd
    pkgs.xrdb
  ];
  xdg.icons.enable = true;
  environment.variables = {
    GTK_THEME = "adw-gtk3";
    XCURSOR = "Bibata-Modern-Ice";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
