{
  inputs,
  pkgs,
  ...
}: {
  services.gnome.evolution-data-server.enable = true;
  services.upower.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    libnotify
    wl-clipboard-rs
    satty
    glib
    adw-gtk3
    gpu-screen-recorder
  ];
  systemd.services.pre-sleep-hook = {
    description = "Run a command before suspend/sleep";
    before = ["sleep.target"];
    wantedBy = ["sleep.target"];
    serviceConfig = {
      Type = "oneshot";
      User = "amr";
      TimeoutStartSec = "5s";
      ExecStart = "${pkgs.writeShellScript "pre-sleep" ''
        export XDG_RUNTIME_DIR="/run/user/$(${pkgs.coreutils}/bin/id -u)"
        SOCK=$(${pkgs.coreutils}/bin/ls "$XDG_RUNTIME_DIR"/noctalia-wayland-*.sock 2>/dev/null | head -n1)
        if [ -z "$SOCK" ]; then
          echo "noctalia socket not found, skipping lock" >&2
          exit 0
        fi
        export WAYLAND_DISPLAY=$(${pkgs.coreutils}/bin/basename "$SOCK" | ${pkgs.gnused}/bin/sed -E 's/noctalia-(wayland-[0-9]+)\.sock/\1/')
        export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
        /run/current-system/sw/bin/noctalia msg session lock
      ''}";
    };
  };
}
