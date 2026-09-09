{pkgs, ...}: {
  environment.systemPackages = [pkgs.openrgb];
  services.udev.packages = [pkgs.openrgb];
  systemd.user.services.openrgb-profile = {
    description = "Apply OpenRGB profile at login";
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.openrgb}/bin/openrgb --noautoconnect -p keyboard";
    };
  };
}
