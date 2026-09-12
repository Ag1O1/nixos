{
  fm,
  pkgs,
  ...
}: {
  imports = [fm.networkmanager fm.nftables];
  services.networkmanager.enable = true;

  providers.firewall.backend = "nftables";
  services.nftables.enable = true;

  custom.persist.directories = [
    "/var/lib/NetworkManager"
    "/etc/NetworkManager/system-connections"
  ];
}
