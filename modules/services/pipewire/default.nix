{config, nixpkgs, lib, ...}:
with lib; let
  cfg = config.modules.services.pipewire;
in {
  options.modules.services.pipewire = {
    enable = lib.mkEnableOption "pipewire";
  };
  config = mkIf cfg.enable {
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
        };
      };
    };
  };
}