{
  config,
  lib,
  pkgs,
  ...
}:{
  hm.wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 4 silent] vesktop"
      "ngrok http --url=goose-neat-sponge.ngrok-free.app 8080"
      "hyprctl setcursor Bibata-Modern-Ice 24"
      "hyprpaper"
      "firefox-beta"
    ];

    windowrulev2 = [
      "workspace 4 silent,class:^(vesktop)$"
      "suppressevent maximize, class:.*" # You'll probably like this.
    ];
  };
}