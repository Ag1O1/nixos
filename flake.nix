{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = { self, nixpkgs, ... } @ inputs:{
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs; };
      modules = [
        ./hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
