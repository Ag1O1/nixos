{
  config,
  lib,
  ...
}:
with lib; {
  hardware = {
    graphics.enable = true;
    nvidia = {
      enable = true;
      modesetting.enable = true;
      kernelModule = "open";
      package = mkDefault config.boot.kernelPackages.nvidiaPackages.bleeding_edge;
      power = {
        suspend.enable = true;
        runtime.enable = true;
      };
    };
  };
}
