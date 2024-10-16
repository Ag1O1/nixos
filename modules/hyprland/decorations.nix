{
  config,
  lib,
  ...
}:{
  hm.wayland.windowManager.hyprland.settings = {
    general = {
      
      gaps_in = 3;
      gaps_out = 6;

      border_size = 2;

      # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false;

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      #allow_tearing = true;

      layout = "dwindle";
    };

    decoration = {
      rounding = 5;

      # Change transparency of focused and unfocused windows
      active_opacity = 1;
      inactive_opacity = 1;

      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";

      # https://wiki.hyprland.org/Configuring/Variables/#blur
      blur = {
          enabled = true;
          size = 4;
          passes = 1;

          vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true;

      # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      #bezier = "myBezier, 0.05, 0.9, 0.1, 1.05"; DEFAULT

      # DYNAMIC
      bezier = [
      "wind, 0.05, 0.9, 0.1, 1.05"
      "winIn, 0.1, 1.1, 0.1, 1.1"
      "winOut, 0.3, -0.3, 0, 1"
      "liner, 1, 1, 1, 1"
      ];
      animation = [
        # DEFAULT
      #"windows, 1, 5, myBezier"
      #"windowsOut, 1, 5, default, popin 80%"
      #"border, 1, 7, default"
      #"borderangle, 1, 5, default"
      #"fade, 1, 5, default"
      #"workspaces, 1, 4, default"
        # DYNAMIC
      "windows, 1, 4, wind, slide"
      "windowsIn, 1, 4, winIn, slide"
      "windowsOut, 1, 5, winOut, slide"
      "windowsMove, 1, 5, wind, slide"
      #"border, 1, 1, liner"
      #"borderangle, 1, 30, liner, loop"
      "fade, 1, 10, default"
      "workspaces, 1, 3, wind"
      ];
    };
      dwindle ={
        pseudotile = true;
        preserve_split = true;
      };
      master ={
        new_status = "master";
      };
  };
}