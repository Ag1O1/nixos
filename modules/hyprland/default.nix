{pkgs, inputs, ...}: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports =
    [
      ./binds.nix
      ./decorations.nix
      ./exec.nix
      ./general.nix
      ./ags
      #inputs.split-monitor-workspaces.default
    ];
  hm = {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #plugins = [
    # inputs.split-monitor-workspaces.packages.x86_64-linux.split-monitor-workspaces
    #];
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
  hardware.graphics = {
    package = pkgs-unstable.mesa.drivers;

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
  hm.programs.hyprlock = {
    enable = true;
      settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "/home/amr/Pictures/wallpapers/lazytea_compose.png";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
    };
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