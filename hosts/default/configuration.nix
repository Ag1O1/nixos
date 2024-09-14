# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, self, inputs, ... }:

{
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      (self + /modules)
    ];
  fileSystems."/run/media/amr/Disk" =
    { device = "/dev/disk/by-uuid/C0C8B459C8B45000";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };
  
  boot.supportedFilesystems = [ "ntfs" ];
  programs.nix-ld.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.direnv.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents..
  services.printing.enable = true;

  services.libinput.enable = true;
  services.ollama.enable = true;
  services.ollama.acceleration = "cuda";
  services.open-webui.enable = true;
  services.open-webui.openFirewall = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amr = {
    isNormalUser = true;
    description = "Amr";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [

    ];
  };
home-manager = {
  # also pass inputs to home-manager modules
  extraSpecialArgs = {inherit inputs;};
  users = {
    "amr" = import ./home.nix;
  };
};
  services.flatpak.enable = true;
  modules.programs.gaming.enable = true;
  custom = {
    firefox.enable = true;
    pipewire.enable = true;
    #gaming.enable = true;
    nvidia.enable = true;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Don't change

}
