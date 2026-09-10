{
  cm,
  fm,
  pkgs,
  lib,
  ...
}: {
  imports = [cm.nix-ld cm.nh fm.nix-daemon];
  services.nix-daemon = {
    enable = true;
    package = pkgs.lix;

    settings = {
      substituters = ["https://attic.xuyh0120.win/lantian" "https://finix.cachix.org"];
      trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" "finix.cachix.org-1:0ejikHDeCp0UErsduUUHcg9IJczY2/h2e5132Z/As/c="];
      auto-optimise-store = true;
      cores = 4;
      experimental-features = [
        "nix-command"
        "flakes"
        "flake-self-attrs"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  environment.systemPackages = [
    pkgs.nix-search-tv
    pkgs.nixd
    pkgs.package-version-server
    pkgs.nil # Used in basically every project for flake.nix, so makes more sense to have it included in the main config
  ];

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
      ];
    };

    # My configuration uses nh as a replacement for the default nixos rebuild command
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = lib.mkDefault "/home/amr/nixos"; # This is the location for the config in all my devices but can be overwritten
    };
  };
}
