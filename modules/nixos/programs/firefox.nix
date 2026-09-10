{pkgs, ...}: {
  # TODO: write config with hjem
  environment.systemPackages = [pkgs.pywalfox-native pkgs.librewolf];
}
