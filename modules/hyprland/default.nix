{pkgs, inputs, ... }: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports =
    [
      ./binds.nix
      ./decorations.nix
      ./exec.nix
      ./general.nix
    ];
  hm.wayland.windowManager.hyprland.enable = true;
  hm.home.sessionVariables.NIXOS_OZONE_WL = "1";
  
  hardware.graphics = {
    package = pkgs-unstable.mesa.drivers;

    # if you also want 32-bit support (e.g for Steam)
    enable32Bit = true;
    package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
  };
  programs.hyprland = {
    enable = true;
   # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  xdg.portal = {
    enable = true;
    #configPackages = mkDefault [
    #cfg.portalPackage
    #];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      #cfg.portalPackage
    ];
    config = {
      common.default = ["gtk" "hyprland"];
    };
  };
}