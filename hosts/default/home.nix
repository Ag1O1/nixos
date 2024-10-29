{ config, pkgs, ... }:

{
  imports = [
    #../../modules/home-manager
  ];
  home.username = "amr";
  home.homeDirectory = "/home/amr";
  services.network-manager-applet.enable = true;
  home.stateVersion = "24.05"; # Please read the comment before changing. (dont change)
  home.sessionVariables = {
    EDITOR = "vscode";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
