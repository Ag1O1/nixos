{
  flake.modules.nixos.bluetooth = {
    hardware.bluetooth.enable = true;
    custom.persist.directories = [
      "/var/lib/bluetooth"
    ];
  };
}
