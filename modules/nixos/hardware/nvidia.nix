{
  config,
  lib,
  ...
}:
with lib; {
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = mkDefault true;
      package = mkDefault config.boot.kernelPackages.nvidiaPackages.bleeding_edge;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
    };
  };
}
