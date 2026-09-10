{
  description = "My nixconf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation.url = "github:nix-community/preservation";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umbriel.url = "git+https://github.com/noctalia-dev/umbriel";
    xdg-desktop-portal-umbriel.url = "github:noctalia-dev/xdg-desktop-portal-umbriel";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    haumea,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    m = haumea.lib.load {
      src = ./modules/nixos;
      loader = haumea.lib.loaders.path;
      inputs = {inherit inputs;};
    };
    sharedModules = [
      m.core.nix
      m.core.networking
      m.core.core-packages
      m.core.preservation
      m.services.mime
      m.services.sops

      m.services.boot
      m.services.plymouth

      m.programs.fish
      m.programs.neovim
      m.theming
      ./modules/users/amr.nix
    ];
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs self;};
        modules =
          sharedModules
          ++ [
            ./modules/hosts/laptop/machine.nix
            ./modules/hosts/laptop/hardware.nix
            ./modules/hosts/laptop/packages.nix
            ./modules/hosts/laptop/kernel.nix
            # Hardware
            m.hardware.nvidia
            m.hardware.asusd
            m.hardware.tlp

            # Programs
            m.programs.nix-search-tv
            m.programs.openrgb
            m.programs.gaming
            m.programs.virt-manager
            m.programs.logisim
            m.programs.tmux
            m.programs.lazygit
            m.programs.obs
            m.programs.waydroid
            m.programs.ly
            m.programs.noctalia
            m.programs.yazi
            m.programs.helium
            m.programs.firefox

            # Services
            m.services.pipewire
            m.services.ssh
            m.services.flatpak
            m.services.printing
            m.services.keyd
            m.services.direnv
            m.services.AI

            # Desktop
            m.desktop.umbriel
          ];
      };
    };
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [nil nixd alejandra];
    };
  };
}
