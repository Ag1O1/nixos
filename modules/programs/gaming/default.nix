{pkgs, config, lib, ...}:
{
  options.custom.gaming = {
    enable = lib.mkEnableOption "gaming";
  };
  config = lib.mkIf config.custom.gaming.enable {
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    environment.systemPackages = with pkgs; [
      mangohud
      lutris
      wineWowPackages.waylandFull
      winetricks
    ];

    programs.gamemode.enable = true;

  };
}