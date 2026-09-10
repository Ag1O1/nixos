{fm, ...}: {
  imports = [fm.pipewire fm.wireplumber fm.rtkit];
  services.rtkit.enable = true;
  programs = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      settings = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [44100 48000];
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 8192;
        };
      };
    };

    wireplumber = {
      enable = true;
      settings = {
        "wireplumber.profiles" = {
          main."monitor.libcamera" = "disabled";
        };
      };
    };
  };
}
