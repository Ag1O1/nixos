{pkgs, ...}: {
  # TODO reconfigure obs
  environment.systemPackages = [pkgs.obs-studio];
}
