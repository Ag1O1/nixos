{pkgs, ...}:
let 
  gruvboxplus = import ./gruvbox-plus.nix {inherit pkgs;};
in {
  imports = [./css.nix];
  
  programs.dconf.enable = true; # NOTE: we need this or gtk breaks
  hm = {
    gtk.enable = true;

    gtk.cursorTheme.package = pkgs.bibata-cursors;
    gtk.cursorTheme.name = "Bibata-Modern-Ice";

    gtk.theme.package = pkgs.adw-gtk3;
    gtk.theme.name = "adw-gtk3";

    gtk.iconTheme.package = gruvboxplus;
    gtk.iconTheme.name = "GruvboxPlus";
  };
}