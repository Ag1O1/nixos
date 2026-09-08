{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.modules.nixos; [
        # Core
        nix
        grub
        core-packages
        preservation

        # Machine specific
        laptopHardware
        laptopPackages
        laptopModule
        laptopKernel

        # Hardware
        networking
        pipewire
        printing
        nvidia
        asusd
        ssh
        tlp

        # User
        user-amr
        mime
        # Modules
        sops
        nix-search-tv
        plymouth
        flatpak
        theming
        fish
        printing
        keyd
        direnv
        AI
        openrgb
        waydroid

        ly
        umbriel
        noctalia

        yazi
        helium
        qutebrowser
        gaming
        virt-manager
        logisim
        tmux
        lazygit
        obs
      ];
    };
    modules.nixos.laptopModule = {
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
        nsearch = "nix search nixpkgs";
        grep = "grep --color=auto";
      };
    };

    modules.nixos.laptopHardware = {
      lib,
      pkgs,
      ...
    }: {
      system.stateVersion = "25.11";
      hardware.facter.reportPath = ./facter.json;
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
      systemd.services.asus-keyboard-ec-mode = {
        description = "Initialize ASUS keyboard RGB controller";

        wantedBy = ["multi-user.target"];

        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${lib.getExe pkgs.hidapitester} --vidpid 0B05:19B6 --open --send-feature 70,1";
        };
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
      };

      ##### File system configuration #####

      services = {
        gvfs.enable = true;
        udisks2.enable = true;
        devmon.enable = true;
      };

      fileSystems = {
        "/" = {
          device = "tmpfs";
          fsType = "tmpfs";
          options = [
            "defaults"
            "size=4G"
            "mode=755"
          ];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/66E7-77B4";
          fsType = "vfat";
          options = ["fmask=0077" "dmask=0077"];
        };
        "/home" = {
          device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
          fsType = "btrfs";
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
          options = [
            "subvol=@swap"
            "noatime"
          ];
        };
        "/nix" = {
          device = "/dev/disk/by-uuid/430c366d-f6d8-4592-a26a-561a29d94de1";
          fsType = "btrfs";
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
          size = 24576; # MiB
        }
      ];
    };
  };
}
