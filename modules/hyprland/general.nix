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
        "HDMI-A-1, preferred, auto-left, 1"
        "DVI-D-1, preferred, auto-right, 1"
      ];
      "$terminal" = "foot";
      "$fileManager" = "nautilus";
      "$browser" = "firefox-developer-edition";
      "$menu" = "ags -c ~/.config/ags/config.js & ags -t applauncher";
      env = [
        "XCURSOR_SIZE,32"
        "HYPRCURSOR_SIZE,32"
        "HYPRCURSOR_THEME,phinger-cursors-light"
      ];
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
      };
      render = {
        explicit_sync = 1;
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
        use_cpu_buffer = true; 
      };

      gestures = {
        workspace_swipe = false;
      };
    };
  };
}
