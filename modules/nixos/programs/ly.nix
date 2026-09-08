{
  flake.modules.nixos.ly = {pkgs, ...}: let
    animation-dur = pkgs.fetchurl {
      url = "https://codeberg.org/fairyglade/ly-community/raw/branch/main/animations/dur/blackhole-smooth-240x67.dur";
      hash = "sha256-wo3FzPtngCsg/bRSDTYHQqKnMp4vY+Btm14vakJERBU=";
    };
  in {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "dur_file";
        dur_file_path = "${animation-dur}";
        full_color = true;
      };
    };
    custom.persist.files = [
      "/etc/ly/save.txt"
    ];
  };
}
