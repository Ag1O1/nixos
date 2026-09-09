{
  lib,
  pkgs,
  ...
}: {
  systemd.services.systemd-machine-id-commit.enable = false;

  boot = {
    extraModprobeConfig =
      lib.mkAfter
      ''
        options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera" max_buffers=2
      '';

    initrd = {
      includeDefaultModules = lib.mkForce false;
      availableKernelModules = [
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

  security = {
    sudo-rs.enable = true;
    sudo.enable = false;
  };

  services = {
    logind.settings.Login.HandleLidSwitch = "ignore";
    gnome.gnome-keyring.enable = true;
    ratbagd.enable = true;
  };
  programs = {
    droidcam.enable = true;
    firejail.enable = true;
    zoxide.enable = true;
    kdeconnect.enable = true;
  };

  environment.shellAliases = {
    os-rebuild = "nh os switch /home/amr/nixos -H laptop";
    os-rebuild-boot = "nh os boot /home/amr/nixos -H laptop";
  };
}
