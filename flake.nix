{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, lix-module } @ inputs:
  let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in
  {

    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit (inputs) self; };
      modules = [
        ./hosts/default/configuration.nix
        lix-module.nixosModules.default
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
