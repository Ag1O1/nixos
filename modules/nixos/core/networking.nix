{
  networking = {
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      #allowedTCPPorts = [];
    };
  };
  custom.persist.directories = [
    "/var/lib/NetworkManager"
    "/etc/NetworkManager/system-connections"
  ];
}
