{
  pkgs,
  cm,
  ...
}: {
  imports = [cm.openrgb];
  services.hardware.openrgb.enable = true;
  finit.services.openrgb-profile = {
    description = "Apply OpenRGB profile at boot";
    runlevels = "2345";
    conditions = "service/syslogd/ready";
    command = "${pkgs.openrgb}/bin/openrgb --noautoconnect -p keyboard";
    user = "amr";
  };
}
