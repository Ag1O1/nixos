{
  imports =
    [
      ./binds.nix
      ./decorations.nix
      ./exec.nix
      ./general.nix
    ];
  wayland.windowManager.hyprland.enable = true;
  home.sessionVariables.NIXOS_OZONE_WL = "1";

}