{
  pkgs,
  cm,
  ...
}: {
  imports = [
    cm.cups
  ];

  services.cups = {
    enable = true;
    drivers = [pkgs.hplipWithPlugin];
  };

  environment.systemPackages = [pkgs.simple-scan];

  custom.persist.directories = [
    "/var/lib/cups"
  ];
}
