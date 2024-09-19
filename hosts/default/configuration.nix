# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, self, inputs, ... }:

{
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware
      ./packages.nix
      (self + /modules)
    ];
  
  #use lix
  nix.package = pkgs.lix;

  #use chachix
    nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.appimage.enable = true;
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.nix-ld.enable = false;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AG";
    LC_IDENTIFICATION = "en_AG";
    LC_MEASUREMENT = "en_AG";
    LC_MONETARY = "en_AG";
    LC_NAME = "en_AG";
    LC_NUMERIC = "en_AG";
    LC_PAPER = "en_AG";
    LC_TELEPHONE = "en_AG";
    LC_TIME = "en_AG";
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amr = {
    isNormalUser = true;
    description = "Amr";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "amr" = import ./home.nix;
    };
  };
  modules = {
    programs = {
    gaming.enable = true;
    firefox.enable = true;
    };
    system.hardware.nvidia.enable = true;
    services.pipewire.enable = true;
  };
    

  programs.direnv.enable = true;
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    xserver.enable = true;

    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    flatpak.enable = true;

    printing.enable = true;
    libinput.enable = true;
    ollama.enable = true;
    ollama.acceleration = "cuda";
    open-webui.enable = true;
    open-webui.openFirewall = true;
    openssh.enable = true;
  };
  

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.05"; # Don't change
}
