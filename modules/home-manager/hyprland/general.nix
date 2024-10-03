{
  config,
  lib,
  ...
}:{
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,auto";
    "$terminal" = "alacritty";
    "$fileManager" = "dolphin";
    "$menu" = "tofi-drun | xargs hyprctl dispatch exec --";
    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];
    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
    };
    input = {
      kb_layout = "us,eg";
      #kb_variant =
      #kb_model =
      #kb_options =
      #kb_rules =

      follow_mouse = 1;
      accel_profile = "flat";
      sensitivity = 0.1;

      touchpad = {
        natural_scroll = false;
      };
    };

    gestures = {
      workspace_swipe = false;
    };
  };
}