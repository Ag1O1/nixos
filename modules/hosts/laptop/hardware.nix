{
  lib,
  pkgs,
  fm,
  ...
}: {
  imports = [fm.gvfs fm.udisks2];
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    amdgpuBusId = "PCI:102:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # Fix for laptop backlight
  # Source: @RPochyly4 in https://gitlab.com/asus-linux/asusctl/-/work_items/682
  finit.services.asus-keyboard-ec-mode = {
    description = "Initialize ASUS keyboard RGB controller";
    runlevels = "2345";
    command = "${lib.getExe pkgs.hidapitester} --vidpid 0B05:19B6 --open --send-feature 70,1";
  };

  boot = {
    kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=30"
      "amdgpu.dcdebugmask=0x410"
      "amdgpu.sg_display=0"
      "nvidia.NVreg_DynamicPowerManagement=0x02"
      "nvidia.NVreg_EnableS0ixPowerManagement=1"
      "nvidia.NVreg_DynamicPowerManagementVideoMemoryThreshold=200"

      "pcie_aspm=force"
    ];
kernelModules = ["kvm-amd" "amdgpu"];
  };

  hardware.firmware = [pkgs.linux-firmware];
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt"];
  boot.initrd.kernelModules = [];
  boot.extraModulePackages = [];

  ##### File system configuration #####

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "tmpfs";
      fsType = "tmpfs";
      neededForBoot = true;
      options = [
        "defaults"
        "size=4G"
        "mode=755"
      ];
    };
    "/tmp" = {
      device = "tmpfs";
      fsType = "tmpfs";
      neededForBoot = true;
      options = [
        "defaults"
        "size=1G"
        "mode=1777"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/66E7-77B4";
      fsType = "vfat";
      neededForBoot = true;
      options = ["fmask=0077" "dmask=0077"];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=@home"
        "compress=zstd:1"
        "noatime"
        "discard=async"
        "autodefrag"
      ];
    };
    "/persistent" = {
      device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=@persistent"
        "compress=zstd:1"
        "noatime"
      ];
    };
    "/home/amr/drive" = {
      device = "/dev/disk/by-uuid/b75ce50d-1020-4784-824a-dae35069d641";
      fsType = "ext4";
      options = ["defaults" "noatime" "nofail"];
    };
    "/home/amr/Downloads" = {
      device = "/home/amr/drive/downloads";
      fsType = "none";
      options = ["bind"];
      depends = ["/home/amr/drive"];
    };
    "/home/amr/Games" = {
      device = "/home/amr/drive/Games";
      fsType = "none";
      options = ["bind"];
      depends = ["/home/amr/drive"];
    };
    "/mnt/swap" = {
      device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=@swap"
        "noatime"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=@nix"
        "compress=zstd:1"
        "noatime"
        "discard=async"
      ];
    };
  };
  swapDevices = [
    {
      device = "/mnt/swap/swapfile";
      #size = 24576; # MiB
    }
  ];
}
