{inputs, ...}: {
  imports = [
    inputs.distro-grub-themes.nixosModules.x86_64-linux.default
  ];

  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
    };
  };
}
