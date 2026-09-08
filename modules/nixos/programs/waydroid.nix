{
  flake.modules.nixos.waydroid = {
    virtualisation.waydroid.enable = true;
    custom.persist.directories = [
      "/var/lib/waydroid"
    ];
  };
}
