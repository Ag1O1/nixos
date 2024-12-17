{
  config,
  lib,
  pkgs,
  ...
}:{
  hm.wayland.windowManager.hyprland.settings = {
    exec-once = [
      "ags -c ~/.config/ags/config.js"
      "sleep 0.4 ; equibop"
      "ngrok http --url=goose-neat-sponge.ngrok-free.app 8080"
      "hyprctl setcursor Bibata-Modern-Ice 24"
      "hyprpaper"
      "$browser"
      "python -m venv ~/discord-ollama-main/bot-env; source ~/discord-ollama-main/bot-env/bin/activate; python ~/discord-ollama-main/main.py"
      "${lib.getExe' pkgs.udiskie "udiskie"}"
      "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit"
      #"wl-paste -p -t text --watch | ${lib.getExe' pkgs.clipman "clipman"} store -P --histpath="~/.local/share/clipman-primary.json"" gives an error
      "${lib.getExe' pkgs.wl-clipboard "wl-paste"} -t text --watch ${lib.getExe' pkgs.clipman "clipman"} store --no-persist"
    ];

    windowrulev2 = [
      "workspace 4 silent,class:^(equibop)$"
      "suppressevent maximize, class:.*" # You'll probably like this. 
      #"immediate, class:^(American Truck Simulator)$"
    ];
  };
}
