{config, nixpkgs, lib, ...}:
with lib; let
  cfg = config.modules.services.pipewire;
in {
  options.modules.services.pipewire = {
    enable = lib.mkEnableOption "pipewire";
  };
  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber = {
        enable = true;
        extraConfig = {
          "10-disable-camera" = {
            "wireplumber.profiles" = {
              main."monitor.libcamera" = "disabled";
            };
          };
          #pipewire."92-low-latency" = {
          #  "context.properties" = {
          #    "default.clock.rate" = 48000;
          #    "default.clock.allowed-rates" = [48000];
          #    "default.clock.quantum" = 2048;
          #    "default.clock.min-quantum" = 1024;
          #  };
          #};
        };
      };
    };
  };
}