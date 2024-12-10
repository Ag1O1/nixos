# REFRENCED FROM RAF'S NYX
{
  config,
  pkgs,
  lib,
  ...
}: with lib; let
  cfg = config.modules.system.hardware.nvidia;
in {
  options.modules.system.hardware.nvidia = {
    enable = lib.mkEnableOption "nvidia";
  };
  config = lib.mkIf cfg.enable {
    # nvidia drivers are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {
        videoDrivers = ["nvidia"];
      }
    ];

    boot.blacklistedKernelModules = ["nouveau"];

    environment = {
      sessionVariables = mkMerge [
        {LIBVA_DRIVER_NAME = "nvidia";
        #WLR_NO_HARDWARE_CURSORS = "1";
        #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
        GBM_BACKEND = "nvidia-drm"; # breaks firefox apparently
        }
      ];
      systemPackages = with pkgs; [
        nvtopPackages.nvidia

        # mesa
        mesa

        # vulkan
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer

        # libva
        libva
        libva-utils
      ];
    };

    hardware = {
      nvidia = {
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
        modesetting.enable = mkDefault true;

        powerManagement = {
          enable = mkDefault true;
          finegrained = mkDefault false;
        };

        open = mkDefault false;
        nvidiaSettings = false; # add nvidia-settings to pkgs, useless on nixos
        nvidiaPersistenced = true;
        forceFullCompositionPipeline = true;
      };

      graphics = {
        extraPackages = with pkgs; [nvidia-vaapi-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
      };
    };
  };
}
