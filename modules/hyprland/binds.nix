{
  config,
  lib,
  pkgs,
  ...
}:{
  hm.wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
    bind =
      [
        "$mainMod, Q, exec, $terminal"
        "$mainMod SHIFT, C, killactive,"
        "$mainMod SHIFT, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, W, exec, $browser"
        "$mainMod, F, togglefloating,"
        "$mainMod SHIFT, F,fullscreen,"
        "$mainMod ALT, F, fullscreenstate, -1 2"
        "$mainMod, R, exec, $menu"
        "$mainMod, V, exec, ${lib.getExe' pkgs.clipman "clipman"} pick -t STDOUT | fuzzel --dmenu | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}"
        "$mainMod, P, pseudo, "
        "$mainMod, J, togglesplit, "

        ",Print, exec, ${lib.getExe pkgs.grimblast} --freeze copy area"
        "SHIFT, Print, exec , ${lib.getExe pkgs.grimblast} --freeze save area - | ${lib.getExe pkgs.satty} -f -"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

      ]/*++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "ALT, code:1${toString i}, split-workspace, ${toString ws}"
            "ALT SHIFT, code:1${toString i}, split-movetoworkspace, ${toString ws}"
          ]
        )
        9)
    )*/++ (
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
    /*
    plugin = {
      split-monitor-workspaces = {
        count = 10;
        keep_focused = 0;
        enable_notifications = 0;
        enable_persistent_workspaces = 0;
      };
    };
    */
    bindm =
    [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
    ];
    bindel =
    [
    ",XF86AudioRaiseVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
    ",XF86AudioStop, exec, ${lib.getExe pkgs.playerctl} Stop"
    ",XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next"
    ",XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous"
    #",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];
  };
}
