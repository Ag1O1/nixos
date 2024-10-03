{
  config,
  lib,
  ...
}:{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
    bind =
      [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, togglefloating,"
        "$mainMod SHIFT, F,fullscreen,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo, "
        "$mainMod, J, togglesplit, "
        ",Print, exec, ${pkgs.grim}/bin/grim -g ${pkgs.slurp}/bin/slurp - | convert - - shave 1x1 PNG:- | wl-copy"
        "SHIFT, Print, exec , ${pkgs.grim}/bin/grim -g ${pkgs.slurp}/bin/slurp - | convert - - shave 1x1 PNG:- | ${pkgs.slurp}/bin/slurp -f -"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "mainMod, mouse_down, workspace, e+1"
        "mainMod, mouse_up, workspace, e-1"

      ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "ALT, code:1${toString i}, workspace, ${toString ws}"
            "ALT SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
    );
    bindm =
    [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
    ];
    bindel =
    [
    ",KP_UP,exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ",KP_Home, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",KP_Prior, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ]
  };
}