{
  inputs,
  pkgs,
  lib,
  ...
}: {
  nix = {
    optimise.automatic = true;
    package = pkgs.lix;

    settings = {
      substituters = ["https://attic.xuyh0120.win/lantian"];
      trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
      cores = 4;
      experimental-features = [
        "nix-command"
        "flakes"
        "flake-self-attrs"
      ];
    };
  };
  nix.channel.enable = false; # nix channels are not needed when using flakes
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
      ];
    };
  };

  services = {
    envfs = {
      enable = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true; # its a pain to manage a system without unfree software
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };
  environment.systemPackages = [
    pkgs.nix-search-tv
    pkgs.nixd
    pkgs.package-version-server
    pkgs.nil # Used in basically every project for flake.nix, so makes more sense to have it included in the main config
  ];
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];
  # My configuration uses nh as a replacement for the default nixos rebuild command
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = lib.mkDefault "/home/amr/nixos"; # This is the location for the config in all my devices but can be overwritten
  };
}
