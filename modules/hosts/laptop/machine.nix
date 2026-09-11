{
  fm,
  cm,
  lib,
  pkgs,
  ...
}: {
  imports = [fm.gnome-keyring fm.sudo fm.bash fm.sysklogd fm.polkit fm.getty fm.iwd fm.niri cm.fastfetch];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;
  boot = {
    initrd = {
      #includeDefaultModules = lib.mkForce false;
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "btrfs"
      ];
    };
  };
  programs.niri.enable = true;
  programs.fastfetch.enable = true;

  finit.runlevel = 3;

  users.users.root.password = "$y$j9T$6xDOxYv1styslfWtv5Dgd.$JVn13FwJ/NyGGJ/urZB0SaeJG7ok3Ul9HcSKxzZVIA8";

  services.polkit.enable = true;
  services.getty.enable = true;
  services.gardendevd.enable = true;
  services.elogind.enable = true;
  #services.seatd.enable = true;
  services.sysklogd.enable = true;
  services.dbus.enable = true;

  programs = {
    bash.enable = true;
    sudo.enable = true;
    gnome-keyring.enable = true;
  };

  hj.xdg.config.files."fish/conf.d/aliases.fish".text = ''
    alias os-rebuild="nh os switch /home/amr/nixos -H laptop"
    alias os-rebuild-boot="nh os boot /home/amr/nixos -H laptop"
  '';
}
