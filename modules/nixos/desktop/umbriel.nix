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
in {
  /*
  imports = [
    inputs.umbriel.nixosModules.default
  ];
  programs.umbriel = {
    enable = true;
    portalPackage = inputs.xdg-desktop-portal-umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  */
  environment.systemPackages = [
    inputs.umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default
    # So `just debug` / meson outside `nix develop` can find headers via pkg-config.
    pkgs.tomlplusplus
  ];
  xdg.portal = {
    enable = lib.mkDefault true;
    portals = [inputs.xdg-desktop-portal-umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default];
  };
  hj = {
    imports = [
      inputs.umbriel.hjemModules.default
    ];
    xdg.config.files."xdg-desktop-portal/portals.conf".text = ''
      [preferred]
      default=umbriel;gtk
    '';
    # TODO check if this one works (and if so delete the one above)
    xdg.config.files."xdg-desktop-portal/umbriel-portals.conf".text = ''
      [preferred]
      default=umbriel;gtk
    '';
    programs.umbriel = {
      enable = true;
      settings = {
        layout.mode = "scrolling";
        general.autostart = ["noctalia"];
        layout.gap = 5;
        input = {
          focus = {
            follows_mouse = true;
            follows_mouse_max_scroll = 0.5;
          };
          touchpad = {
            natural_scroll = true;
            accel_profile = "flat";
            sensitivity = 1;
          };
          mouse = {
            accel_profile = "flat";
          };
          keyboard = {
            repeat_rate = 30;
            repeat_delay = 300;
            layout = "us,eg";
          };
        };
        environment = {
          PROTONPATH = "GE-Proton";
          SSH_AUTH_SOCK = "/home/amr/.bitwarden-ssh-agent.sock";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          QT_QPA_PLATFORMTHEME = "qt6ct";
          QT_QPA_PLATFORM = "wayland";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        };
        keybinds = {
          "Mod+Shift+O" = "config-reload";
          "Mod+Shift+DELETE" = "session-quit";
          "Mod+Space" = "keyboard-layout-next";

          ### Apps ###
          "Mod+Q" = "spawn:ghostty";
          "Mod+P" = "spawn:/home/amr/.config/noctalia/hooks/performance-on.sh";
          "Mod+Shift+P" = "spawn:/home/amr/.config/noctalia/hooks/performance-off.sh";
          "Mod+Shift+C" = "window-close";
          "Mod+S" = "spawn:${lib.getExe pkgs.wlr-which-key}";
          "Mod+W" = "spawn:librewolf";
          "Mod+E" = "spawn:ghostty -e yazi";
          "Mod+A" = "spawn:${lib.getExe pkgs.hyprmag} -r 2500";
          "Mod+T" = "spawn:ghostty -e ${scripts.todo}";

          "Mod+G" = "spawn:noctalia msg panel-toggle control-center";
          "Mod+R" = "spawn:noctalia msg panel-toggle launcher";
          "Mod+CTRL+R" = "spawn:noctalia msg panel-toggle control-center";
          "Mod+Shift+R" = "spawn:noctalia msg panel-toggle clipboard";

          "Mod+Shift+S" = "spawn:noctalia msg screenshot-region";
          "Mod+Shift+Alt+S" = "spawn:noctalia msg screenshot-fullscreen";
          "Mod+Shift+Ctrl+S" = ''spawn:${lib.getExe' pkgs.wl-clipboard "wl-paste"} | ${lib.getExe pkgs.satty} --filename -'';

          ### XF86 Keys ###
          "XF86AudioRaiseVolume" = "spawn:noctalia msg volume-up";
          "XF86AudioLowerVolume" = "spawn:noctalia msg volume-down";
          "XF86AudioMute" = "spawn:noctalia msg volume-mute";
          "XF86AudioMicMute" = "spawn:noctalia msg mic-mute";
          "XF86AudioNext" = "spawn:noctalia msg media next";
          "XF86AudioPause" = "spawn:noctalia msg media toggle";
          "XF86AudioPlay" = "spawn:noctalia msg media toggle";
          "XF86AudioPrev" = "spawn:noctalia msg media previous";
          "XF86MonBrightnessUp" = "spawn:noctalia msg brightness-up";
          "XF86MonBrightnessDown" = "spawn:noctalia msg brightness-down";

          ### Workspaces ###
          "Mod+1" = "workspace-switch:1";
          "Mod+2" = "workspace-switch:2";
          "Mod+3" = "workspace-switch:3";
          "Mod+4" = "workspace-switch:4";
          "Mod+5" = "workspace-switch:5";
          "Mod+6" = "workspace-switch:6";
          "Mod+7" = "workspace-switch:7";
          "Mod+8" = "workspace-switch:8";
          "Mod+9" = "workspace-switch:9";

          "Mod+Shift+1" = "window-move-to-workspace:1";
          "Mod+Shift+2" = "window-move-to-workspace:2";
          "Mod+Shift+3" = "window-move-to-workspace:3";
          "Mod+Shift+4" = "window-move-to-workspace:4";
          "Mod+Shift+5" = "window-move-to-workspace:5";
          "Mod+Shift+6" = "window-move-to-workspace:6";
          "Mod+Shift+7" = "window-move-to-workspace:7";
          "Mod+Shift+8" = "window-move-to-workspace:8";
          "Mod+Shift+9" = "window-move-to-workspace:9";

          "Mod+Z" = "window-focus-left";
          "Mod+X" = "window-focus-right";
          "Mod+D" = "workspace-previous";
          "Mod+C" = "workspace-next";
          "Mod+h" = "window-focus-left";
          "Mod+l" = "window-focus-right";
          "Mod+k" = "workspace-previous";
          "Mod+j" = "workspace-next";

          "Mod+Ctrl+1" = "workspace-set-layout:scrolling";
          "Mod+Ctrl+2" = "workspace-set-layout:dwindle";
          "Mod+Ctrl+3" = "workspace-set-layout:master";

          "Mod+F" = "window-toggle-maximize";
          "Mod+ALT+F" = "window-toggle-maximize-to-edges";
          "Mod+Shift+F" = "window-toggle-fullscreen";
          "Mod+V" = "window-toggle-floating";
          "Mod+Shift+V" = "window-toggle-pinned";

          "Mod+TAB" = "overview-toggle";
        };
        hot_corners.top_left = {
          enabled = true;
          delay_ms = 200;
          action = "overview-toggle";
        };

        ### Rules ###
        layer_rule = [
          {
            match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
            blur = true;
            blur_ignore_alpha = 0.5;
            blur_popups = true;
          }
        ];
        window_rule = [
          {
            blur = true;
            blur_optimized = true;
          }
        ];

        ### Appearance ###
        appearance.blur = {
          optimized = true;
          passes = 4;
          radius = 5;
          noise = 0.03;
          brightness = 0.75;
          contrast = 0.8;
          saturation = 1.15;
        };

        ### Overview ###
        overview = {
          zoom = 0.5;
          background_blur = true;
          workspace_wallpaper = true;
          shortcuts = false;
        };

        ### Outputs ###
        output.eDP-1 = {
          mode = "1920x1200@165";
          vrr = "always";
          direct_scanout = true;
        };
        drm = {
          ignored_pci_addresses = ["0000:01:00.0"];
        };

        # Noctalia theme colors & writable for some script stuff

        include.files = ["~/.config/umbriel/noctalia.toml" "~/.config/umbriel/writable.toml"];
      };
    };
  };
}
