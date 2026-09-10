{
  fm,
  lib,
  ...
}: {
  imports = [fm.gnome-keyring fm.sudo];
  boot = {
    initrd = {
      #includeDefaultModules = lib.mkForce false;
      availableKernelModules = lib.mkForce [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "btrfs"
      ];
    };
  };

  finit.runlevel = 3;

  users.users.root.password = "$y$j9T$6xDOxYv1styslfWtv5Dgd.$JVn13FwJ/NyGGJ/urZB0SaeJG7ok3Ul9HcSKxzZVIA8";

  services.udev.enable = true;
  services.seatd.enable = true;

  programs = {
    sudo.enable = true;
    gnome-keyring.enable = true;
  };

  hj.xdg.config.files."fish/conf.d/aliases.fish".text = ''
    alias os-rebuild="nh os switch /home/amr/nixos -H laptop"
    alias os-rebuild-boot="nh os boot /home/amr/nixos -H laptop"
  '';
}
