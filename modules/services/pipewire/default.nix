{config, nixpkgs, lib, ...}:
with lib; let
  cfg = config.modules.services.pipewire;
in {
  options.modules.services.pipewire = {
    enable = lib.mkEnableOption "pipewire";
  };
  config = mkIf cfg.enable {
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;

      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
    };
  };
}