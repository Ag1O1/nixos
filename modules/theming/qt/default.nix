{pkgs, ...}: {
  qt = {
  enable = true;
  style = "adwaita";
  platformTheme = "gnome";
  };
  hm.home = {
      packages = with pkgs; [
        qt5.qttools
        qt6Packages.qtstyleplugin-kvantum
        libsForQt5.qtstyleplugin-kvantum
        libsForQt5.qt5ct
      ];
    sessionVariables = {
      # Scaling factor for QT applications
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        # Use wayland as the default backend.
      QT_QPA_PLATFORM = "wayland";
        # Disable window decorations for qt applications.
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        # Remain compatible with QT5 whenever possible.
      DISABLE_QT_COMPAT = "0";
        # Tell Calibre to use the dark theme.
      CALIBRE_USE_DARK_PALETTE = "1";
    };
  };
}