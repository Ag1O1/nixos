{config, nixpkgs, lib, ...}:
{
  options.custom.pipewire = {
    enable = lib.mkEnableOption "pipewire";
  };
  config = lib.mkIf config.custom.pipewire.enable {
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}