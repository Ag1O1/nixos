{
  config,
  lib,
  ...
}:{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 2 silent] ${pkgs.foot}/bin/foot"
      "[workspace 4 silent] vesktop"
      "ngrok http --url=goose-neat-sponge.ngrok-free.app 8080"
      "hyprctl setcursor Bibata-Modern-Ice 24"
      "hyprpaper"
      "firefox-beta"
    ];
  };
}