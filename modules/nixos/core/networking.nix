{fm, ...}: {
  imports = [fm.networkmanager];
  services.networkmanager.enable = true;
  custom.persist.directories = [
    "/var/lib/NetworkManager"
    "/etc/NetworkManager/system-connections"
  ];
}
