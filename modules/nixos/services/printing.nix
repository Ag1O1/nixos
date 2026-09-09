{pkgs, ...}: {
  environment.systemPackages = [pkgs.simple-scan];
  services.printing = {
    enable = true;
    drivers = [pkgs.hplipWithPlugin];
  };
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.hplipWithPlugin];
  };
  custom.persist.directories = [
    "/var/lib/cups"
  ];
}
