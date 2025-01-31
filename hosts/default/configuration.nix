# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  self,
  lib,
  nix-colors,
  stable-pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hardware
    ./packages.nix
    (self + /modules)
    (
      lib.mkAliasOptionModule
      ["hm"]
      [
        "home-manager"
        "users"
        "amr"
      ]
    )
    inputs.spicetify-nix.nixosModules.default
  ];
  environment.systemPackages = [
    #   inputs.umu.packages.${pkgs.system}.umu
    (pkgs.writers.writeFishBin "nrun" ''
      if echo "$argv[1]" | grep -Eq '^[a-z]+:.+/.+$'
          nix run $argv[1] -- $argv[2..]
      else
          nix run nixpkgs#$argv[1] -- $argv[2..]
      end
    '')
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
  programs.fish = {
    enable = true;
    #shellAliases = {
    #run = "nix run ";
    #shell = "nix shell "; #todo: this
    #};
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
  programs.appimage.enable = true;
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  #programs.seahorse.enable = true; REACTIVATE AFTER YOUR DONE GNOME
  services.gnome.gnome-keyring.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # Enable networking
  networking.networkmanager.enable = true;
  virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableKvm = true;

  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amr = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Amr";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "scanner"
      "lp"
      "vidio"
      "kvm"
      "libvirt"
    ];
  };
  home-manager = {
    backupFileExtension = "backup3";
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "amr" = import ./home.nix;
    };
    extraSpecialArgs = {
      inherit nix-colors;
    };
  };
  modules = {
    programs = {
      fuzzel.enable = true;
      #vm.enable = true; QEMU BROKEN
      tmux.enable = true;
      gaming.enable = true;
      firefox.enable = true;
      foot.enable = true;
      spotify.enable = true;
      discord.enable = true;
      nvf.enable = true;
    };
    system.hardware = {
      nvidia.enable = true;
      printing.enable = true;
    };
    services = {
      pipewire.enable = true;
      bluetooth.enable = true;
    };
  };

  programs.direnv.enable = true;
  programs.sway.enable = true;
  environment.pathsToLink = ["/libexec"]; #idk if i need this
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    xserver = {
      desktopManager.gnome.enable = true;
      #desktopManager.xterm.enable = true;
      windowManager.i3.enable = true;
      enable = true;
      wacom.enable = true;
      displayManager.sddm.enable = false;
      displayManager.lightdm.enable = false;
    };
    flatpak.enable = true;

    libinput.enable = true;

    ollama.enable = true;
    ollama.acceleration = "cuda";
    ollama.package = pkgs.ollama;
    ollama.environmentVariables = {
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q4_0";
    };

    open-webui.enable = true;
    #open-webui.openFirewall = true;
    openssh.enable = true;
  };
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.hplipWithPlugin];
  };
  virtualisation.waydroid.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking.firewall.allowedTCPPorts = [
    7777
    25565
    49185
  ];
  networking.firewall.enable = false;

  #networking.firewall.allowedUDPPorts = [19132];

  system.stateVersion = "24.05"; # Don't change
}
