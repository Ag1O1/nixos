# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, self, lib, nix-colors, ... }:

{
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware
      ./packages.nix
      (self + /modules)
      (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" "amr"])
    ];
  #use lix
  nix.package = pkgs.lix;

  #use chachix
    nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  
  environment.systemPackages = [  
    inputs.umu.packages.${pkgs.system}.umu
    ];
  systemd.user.services.polkit-pantheon-authentication-agent-1 = {
      description = "Pantheon PolicyKit agent";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
    };
  programs.fish.enable = true;
  
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
  programs.appimage.enable = true;
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.nix-ld.enable = false;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nixos"; # Define your hostname.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # Enable networking
  networking.networkmanager.enable = true;
  virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableKvm = true;

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
    shell = pkgs.fish;
    description = "Amr";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users = {
      "amr" = import ./home.nix;
    };
    extraSpecialArgs = {
      inherit nix-colors;
    };
  };
  modules = {
    programs = {
    gaming.enable = true;
    firefox.enable = true;
    foot.enable = true;
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
    xserver.wacom.enable = true;
    #displayManager.sddm.enable = true;
    #xserver.desktopManager.cinnamon.enable = true;
    #desktopManager.plasma6.enable = true;

    flatpak.enable = true;

    printing.enable = true;
    libinput.enable = true;
    ollama.enable = true;
    ollama.acceleration = "cuda";
    #open-webui.enable = true;
    #open-webui.openFirewall = true;
    openssh.enable = true;
  };
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.05"; # Don't change
}
