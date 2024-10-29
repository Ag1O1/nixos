{ pkgs, inputs, ... }:
{
  nix.settings = {
    package = pkgs.lix;

    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    
    optimise.automatic = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  programs.nix-ld.enable = false;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    pkgs.nixd
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
