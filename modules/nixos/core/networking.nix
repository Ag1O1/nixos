{
  fm,
  pkgs,
  ...
}: {
  imports = [fm.networkmanager];
  services.networkmanager.enable = true;

  # Ensure wpa_supplicant is available for Wi-Fi
  environment.systemPackages = [pkgs.wpa_supplicant];

  # Make sure the group exists
  users.groups.networkmanager = {};
  custom.persist.directories = [
    "/var/lib/NetworkManager"
    "/etc/NetworkManager/system-connections"
  ];
}
