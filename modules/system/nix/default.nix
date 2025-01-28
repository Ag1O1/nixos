{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-6.0.36"
  ];
  nix = {
    package = pkgs.lix;
    optimise.automatic = true;

    settings = {
      substituters = ["https://hyprland.cachix.org" "https://cosmic.cachix.org/"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  programs.nix-ld.enable = false;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    pkgs.nixd
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
