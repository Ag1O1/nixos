{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:{
  hm.wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "HDMI-A-1, 1920x1080@60, 0x0, 1"
        "DVI-D-1, 1600x900@60, 1920x90, 1"
      ];
      "$terminal" = "foot";
      "$fileManager" = "nautilus";
      "$browser" = "firefox-developer-edition";
      "$menu" = "ags -c ~/.config/ags/config.js & ags -t applauncher";
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Bibata-Modern-Ice"
      ];
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
      };
      input = {
        kb_layout = "us,eg";
        #kb_variant = ",qwerty";
        #kb_model =
        kb_options = "grp:win_space_toggle";
        #kb_rules =

        follow_mouse = 1;
        accel_profile = "flat";
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };
      cursor = {
        no_hardware_cursors = false; 
        allow_dumb_copy = true;
      };

      gestures = {
        workspace_swipe = false;
      };
    };
  };
}
