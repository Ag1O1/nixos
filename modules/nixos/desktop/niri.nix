{
  inputs,
  pkgs,
  lib,
  ...
}: let
  mkScript = name: pkgs.writeShellScript name (builtins.readFile ./scripts/${name});
  fileNames = builtins.attrNames (builtins.readDir ./scripts);
  scripts = builtins.listToAttrs (map (name: {
      name = lib.removeSuffix ".sh" name;
      value = mkScript name;
    })
    fileNames);
  myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
    inherit pkgs;
    settings = {
      # ════════════════════════════════════════════════════════════
      # Debug
      # ════════════════════════════════════════════════════════════
      debug.honor-xdg-activation-with-invalid-serial = _: {};

      # ════════════════════════════════════════════════════════════
      # Workspaces
      # ════════════════════════════════════════════════════════════

      # ════════════════════════════════════════════════════════════
      # Overview
      # ════════════════════════════════════════════════════════════
      overview.zoom = 0.50;

      # ════════════════════════════════════════════════════════════
      # Cursor
      # ════════════════════════════════════════════════════════════
      cursor.xcursor-theme = "Bibata-Modern-Ice";

      # ════════════════════════════════════════════════════════════
      # Miscellaneous
      # ════════════════════════════════════════════════════════════
      prefer-no-csd = _: {};

      screenshot-path = null;

      hotkey-overlay.skip-at-startup = _: {};

      # ════════════════════════════════════════════════════════════
      # Global Blur Defaults
      # ════════════════════════════════════════════════════════════
      blur = {
        passes = 4;
        offset = 2.0;
        noise = 0.03;
        saturation = 1.25;
      };

      # ════════════════════════════════════════════════════════════
      # Layer Rules
      # ════════════════════════════════════════════════════════════
      layer-rules = [
        {
          matches = [{namespace = "^noctalia-backdrop";}];
          place-within-backdrop = true;
        }
      ];

      # ════════════════════════════════════════════════════════════
      # Window Rules
      # ════════════════════════════════════════════════════════════
      window-rules = [
        # Global blur — no matches = applies to all windows
        {
          background-effect = {
            blur = true;
            xray = false;
          };
        }
        {
          matches = [{app-id = "equibop";}];
          open-on-workspace = "chat";
        }
        # No border background on any window
        {
          draw-border-with-background = false;
        }
        # Float Firefox PiP and satty
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
            {app-id = "com.gabm.satty";}
          ];
          open-floating = true;
        }
        # Block screen capture for sensitive apps
        {
          matches = [
            {app-id = "^org\\.keepassxc\\.KeePassXC$";}
            {app-id = "^org\\.gnome\\.World\\.Secrets$";}
            {app-id = "Bitwarden";}
            {title = "Bitwarden";}
            {app-id = "com.rtosta.zapzap";}
            {title = "ZapZap";}
          ];
          block-out-from = "screen-capture";
        }
        # Rounded corners for all windows
        {
          geometry-corner-radius = 20;
          clip-to-geometry = true;
        }
      ];

      # ════════════════════════════════════════════════════════════
      # Input
      # ════════════════════════════════════════════════════════════
      input = {
        keyboard = {
          xkb = {
            layout = "us,eg";
            options = "grp:win_space_toggle,compose:ralt";
          };
          repeat-delay = 301;
          repeat-rate = 31;
        };

        touchpad = {
          accel-speed = 1.0;
          accel-profile = "flat";
          tap = _: {}; # bare KDL node
          natural-scroll = _: {}; # bare KDL node
        };

        mouse = {
          accel-profile = "flat";
          accel-speed = 0.25;
        };

        # `focus-follows-mouse max-scroll-amount="10%"` — node with a KDL property
        focus-follows-mouse = _: {
          props.max-scroll-amount = "10%";
        };

        workspace-auto-back-and-forth = _: {}; # bare KDL node
      };

      # ════════════════════════════════════════════════════════════
      # Layout
      # ════════════════════════════════════════════════════════════
      layout = {
        gaps = 16;
        center-focused-column = "on-overflow";

        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        focus-ring = {
          on = _: {}; # bare `on` identifier — matches original `on //ring`
          width = 3;
        };

        border = {
          off = _: {}; # bare `off` identifier — disables border
          width = 5;
        };

        shadow = {
          softness = 30;
          spread = 5;
          # `offset x=0 y=5` — node with KDL properties
          offset = _: {
            props = {
              x = 0;
              y = 5;
            };
          };
        };

        struts = _: {}; # empty block
      };

      # ════════════════════════════════════════════════════════════
      # Outputs
      # ════════════════════════════════════════════════════════════
      outputs = {
        "eDP-2" = {
          mode = "1920x1200@165";
          variable-refresh-rate = _: {}; # bare KDL node
          # `position x=0 y=0` — node with KDL properties
          position = _: {
            props = {
              x = 0;
              y = 0;
            };
          };
          scale = 1.0;
        };
        "eDP-1" = {
          mode = "1920x1200@165";
          variable-refresh-rate = _: {};
          position = _: {
            props = {
              x = 0;
              y = 0;
            };
          };
          scale = 1.0;
        };
      };

      # ════════════════════════════════════════════════════════════
      # Animations
      # ════════════════════════════════════════════════════════════
      animations = {
        # `spring damping-ratio=0.75 stiffness=600 epsilon=0.001`
        # spring's params are KDL properties (inline key=val), so use `props`
        overview-open-close.spring = _: {
          props = {
            damping-ratio = 0.75;
            stiffness = 600;
            epsilon = 0.001;
          };
        };
        workspace-switch.spring = _: {
          props = {
            damping-ratio = 0.8;
            stiffness = 555;
            epsilon = 0.0001;
          };
        };
        horizontal-view-movement.spring = _: {
          props = {
            damping-ratio = 0.85;
            stiffness = 700;
            epsilon = 0.0001;
          };
        };
        window-open.spring = _: {
          props = {
            damping-ratio = 0.9;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };

        # Custom easing animation — duration-ms/curve/custom-shader are child nodes
        window-close = {
          duration-ms = 700;
          curve = "linear";
          custom-shader = ''
            vec4 fall_and_rotate(vec3 coords_geo, vec3 size_geo) {
                float progress = niri_clamped_progress * niri_clamped_progress;
                vec2 coords = (coords_geo.xy - vec2(0.5, 1.0)) * size_geo.xy;
                coords.y -= progress * 2880.0;
                float random = (niri_random_seed - 0.5) / 2.0;
                random = sign(random) - random;
                float max_angle = 0.5 * random;
                float angle = progress * max_angle;
                mat2 rotate = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
                coords = rotate * coords;
                coords_geo = vec3(coords / size_geo.xy + vec2(0.5, 1.0), 1.0);
                vec3 coords_tex = niri_geo_to_tex * coords_geo;
                vec4 color = texture2D(niri_tex, coords_tex.st);
                return color;
            }
            vec4 close_color(vec3 coords_geo, vec3 size_geo) {
                return fall_and_rotate(coords_geo, size_geo);
            }
          '';
        };

        window-resize.spring = _: {
          props = {
            damping-ratio = 0.8;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
        window-movement.spring = _: {
          props = {
            damping-ratio = 0.7;
            stiffness = 650;
            epsilon = 0.0001;
          };
        };
      };

      # ════════════════════════════════════════════════════════════
      # Environment Variables
      # ════════════════════════════════════════════════════════════
      environment = {
        PROTONPATH = "GE-Proton";
        SSH_AUTH_SOCK = "/home/amr/.bitwarden-ssh-agent.sock";
        DISPLAY = ":1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        QT_QPA_PLATFORMTHEME = "qt6ct";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
      };

      # ════════════════════════════════════════════════════════════
      # Startup Applications
      # ════════════════════════════════════════════════════════════
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
      spawn-sh-at-startup = [
        "xwayland-satellite"
        "/usr/lib/polkit-kde-authentication-agent-1 &"
        "equibop"
        "zapzap"
        "bitwarden"
        "noctalia --daemon"
        "gentoo-pipewire-launcher"
      ];

      # ════════════════════════════════════════════════════════════
      # Keybindings
      #
      # Simple bind (no bind-level flags):
      #   "Mod+H".focus-column-left = _: { };
      #
      # Bind with flags (repeat / allow-when-locked / cooldown-ms / hotkey-overlay-title):
      #   "Mod+P" = _: {
      #     props.repeat = false;          ← KDL property on the bind node itself
      #     content.spawn-sh = "...";      ← the action as child node
      #   };
      # ════════════════════════════════════════════════════════════
      binds = {
        # ─── Performance Toggles ──────────────────────────────────────────────
        "Mod+P" = _: {
          props.repeat = false;
          content.spawn-sh = "/home/amr/.config/noctalia/hooks/performance-on.sh";
        };
        "Mod+Shift+P" = _: {
          props.repeat = false;
          content.spawn-sh = "/home/amr/.config/noctalia/hooks/performance-off.sh";
        };
        "Mod+M" = _: {
          props.repeat = false;
          content.spawn-sh = ''wl-mirror $(niri msg --json focused-output | jq -r .name)'';
        };
        "Mod+Shift+Escape".show-hotkey-overlay = _: {};

        # ─── Applications ─────────────────────────────────────────────────────
        "Mod+Q" = _: {
          props.hotkey-overlay-title = "Open Terminal: Ghostty";
          content.spawn-sh = "ghostty";
        };
        "Mod+SHIFT+Q" = _: {
          props.hotkey-overlay-title = "Open Terminal: Ghostty";
          content.spawn-sh = lib.getExe pkgs.foot;
        };
        "Mod+S" = _: {
          props.hotkey-overlay-title = "Open wlr-which-key";
          content.spawn-sh = "wlr-which-key";
        };
        "Mod+W" = _: {
          props.hotkey-overlay-title = "Open Browser";
          content.spawn-sh = "helium";
        };
        "Mod+Alt+L" = _: {
          props.hotkey-overlay-title = "Lock Screen: swaylock";
          content.spawn-sh = "swaylock";
        };
        "Mod+E" = _: {
          props.hotkey-overlay-title = "File Manager: yazi";
          content.spawn-sh = "ghostty -e yazi";
        };
        "Mod+T" = _: {
          props.hotkey-overlay-title = "Open TODO";
          content.spawn-sh = "ghostty -e ${scripts.todo}";
        };

        # ─── Audio Controls ───────────────────────────────────────────────────
        "XF86AudioRaiseVolume" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg volume-up";
        };
        "XF86AudioLowerVolume" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg volume-down";
        };
        "XF86AudioMute" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg volume-mute";
        };
        "XF86AudioMicMute" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg mic-mute";
        };
        "XF86AudioNext" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg media next";
        };
        "XF86AudioPause" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg media toggle";
        };
        "XF86AudioPlay" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg media toggle";
        };
        "XF86AudioPrev" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg media previous";
        };
        "XF86MonBrightnessUp" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg brightness-up";
        };
        "XF86MonBrightnessDown" = _: {
          props.allow-when-locked = true;
          content.spawn-sh = "noctalia msg brightness-down";
        };

        # ─── Window Management ────────────────────────────────────────────────
        "Mod+Shift+C".close-window = _: {};

        "Mod+Ctrl+Equal".spawn-sh = ".config/niri/scripts/incZoom.sh";
        "Mod+Ctrl+Minus".spawn-sh = ".config/niri/scripts/decZoom.sh";
        "Mod+Ctrl+Shift+Equal".spawn-sh = ".config/niri/scripts/resetZoom.sh";

        # Focus — arrows + home-row
        "Mod+Left".focus-column-left = _: {};
        "Mod+H".focus-column-left = _: {};
        "Mod+Right".focus-column-right = _: {};
        "Mod+L".focus-column-right = _: {};
        "Mod+Up".focus-window-up = _: {};
        "Mod+K".focus-window-up = _: {};
        "Mod+Down".focus-window-down = _: {};
        "Mod+J".focus-window-down = _: {};

        # Focus — Z/X/C/D aliases
        "Mod+Z".focus-column-left = _: {};
        "Mod+X".focus-column-right = _: {};
        "Mod+C".focus-workspace-down = _: {};
        "Mod+D".focus-workspace-up = _: {};

        # Move columns / windows
        "Mod+Ctrl+Left".move-column-left = _: {};
        "Mod+Ctrl+H".move-column-left = _: {};
        "Mod+Ctrl+Right".move-column-right = _: {};
        "Mod+Ctrl+L".move-column-right = _: {};
        "Mod+Ctrl+Up".move-window-up = _: {};
        "Mod+Ctrl+K".move-window-up = _: {};
        "Mod+Ctrl+Down".move-window-down = _: {};
        "Mod+Ctrl+J".move-window-down = _: {};

        # First / last column
        "Mod+Home".focus-column-first = _: {};
        "Mod+End".focus-column-last = _: {};
        "Mod+Ctrl+Home".move-column-to-first = _: {};
        "Mod+Ctrl+End".move-column-to-last = _: {};

        # Monitor focus / move
        "Mod+Shift+Left".focus-monitor-left = _: {};
        "Mod+Shift+Right".focus-monitor-right = _: {};
        "Mod+Shift+Up".focus-monitor-up = _: {};
        "Mod+Shift+Down".focus-monitor-down = _: {};

        "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = _: {};
        "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = _: {};
        "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = _: {};
        "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = _: {};

        # ─── Workspace Switching ──────────────────────────────────────────────
        "Mod+WheelScrollDown" = _: {
          props.cooldown-ms = 150;
          content.focus-workspace-down = _: {};
        };
        "Mod+WheelScrollUp" = _: {
          props.cooldown-ms = 150;
          content.focus-workspace-up = _: {};
        };
        "Mod+Ctrl+WheelScrollDown" = _: {
          props.cooldown-ms = 150;
          content.move-column-to-workspace-down = _: {};
        };
        "Mod+Ctrl+WheelScrollUp" = _: {
          props.cooldown-ms = 150;
          content.move-column-to-workspace-up = _: {};
        };

        "Mod+MouseForward".focus-column-right = _: {};
        "Mod+MouseBack".focus-column-left = _: {};
        "Mod+Ctrl+WheelScrollRight".move-column-right = _: {};
        "Mod+Ctrl+WheelScrollLeft".move-column-left = _: {};

        "Mod+Shift+WheelScrollDown".focus-column-right = _: {};
        "Mod+Shift+WheelScrollUp".focus-column-left = _: {};
        "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = _: {};
        "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = _: {};

        # Workspace numbers
        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;

        "Mod+Ctrl+1".move-column-to-workspace = 1;
        "Mod+Ctrl+2".move-column-to-workspace = 2;
        "Mod+Ctrl+3".move-column-to-workspace = 3;
        "Mod+Ctrl+4".move-column-to-workspace = 4;
        "Mod+Ctrl+5".move-column-to-workspace = 5;
        "Mod+Ctrl+6".move-column-to-workspace = 6;
        "Mod+Ctrl+7".move-column-to-workspace = 7;
        "Mod+Ctrl+8".move-column-to-workspace = 8;
        "Mod+Ctrl+9".move-column-to-workspace = 9;

        "Mod+Tab".toggle-overview = _: {};
        "Mod+a".spawn-sh = "hyprmag -r 2000";

        # ─── Layout Controls ──────────────────────────────────────────────────
        "Mod+F".maximize-column = _: {};
        "Mod+Ctrl+C".center-visible-columns = _: {};
        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";
        "Mod+Shift+Minus".set-window-height = "-10%";
        "Mod+Shift+Equal".set-window-height = "+10%";

        # ─── Noctalia Panels ──────────────────────────────────────────────────
        "Mod+G".spawn-sh = "noctalia msg panel-toggle control-center";
        "Mod+R".spawn-sh = "noctalia msg panel-toggle launcher";
        "Mod+Ctrl+R".spawn-sh = "noctalia msg panel-toggle emoji";
        "Mod+Shift+R".spawn-sh = "noctalia msg panel-toggle clipboard";

        # ─── Window Modes ─────────────────────────────────────────────────────
        "Mod+V".toggle-window-floating = _: {};
        "Mod+Shift+F".fullscreen-window = _: {};
        "Mod+Alt+F".maximize-window-to-edges = _: {};
        "Mod+Ctrl+F".toggle-windowed-fullscreen = _: {};

        # ─── Screenshots ──────────────────────────────────────────────────────
        "Mod+Shift+S".screenshot = _: {};
        "Mod+Shift+Alt+S".screenshot-window = _: {};
        "Mod+Shift+Ctrl+S".spawn-sh = "wl-paste --type image/png | satty -f -";

        # ─── Emergency Escape ─────────────────────────────────────────────────
        "Mod+Escape" = _: {
          props.allow-inhibiting = false;
          content.toggle-keyboard-shortcuts-inhibit = _: {};
        };

        # ─── Exit / Power ─────────────────────────────────────────────────────
        "Ctrl+Alt+Delete".quit = _: {};
        "Mod+O" = _: {
          props.repeat = false;
          content.toggle-overview = _: {};
        };
      };
      extraConfig = ''
        workspace "browser"
        workspace "main1"
        workspace "main2"
        workspace "chat"
        include optional=true "/home/amr/.config/niri/layout.kdl"
        include optional=true "/home/amr/.config/niri/window-rules.kdl"
        include optional=true "/home/amr/.config/niri/animations.kdl"
        include optional=true "/home/amr/.config/niri/noctalia.kdl"

      '';
    };
  };
in {
  programs.niri = {
    package = myNiri;
    enable = true;
  };
  environment.systemPackages = [pkgs.xwayland-satellite pkgs.wlr-which-key pkgs.hyprmag];
}
