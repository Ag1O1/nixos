{pkgs, ...}: {
  environment.systemPackages = [pkgs.qutebrowser];
  hj.xdg.config.files."qutebrowser/config.py".text =
    #python
    ''
      config.load_autoconfig()
      config.source("noctalia/colors.py")

      c.tabs.position = "left"
      c.tabs.width = "5%"

      c.qt.chromium.process_model = "process-per-site"

      c.colors.statusbar.private.bg = "#8B0000"
      c.colors.statusbar.private.fg = "#FFFFFF"

    '';
}
