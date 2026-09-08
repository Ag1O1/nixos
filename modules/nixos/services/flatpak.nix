{
  flake.modules.nixos.flatpak = {
    services.flatpak.enable = true;
    custom.persist.directories = [
      "/var/lib/flatpak"
    ];
  };
}
