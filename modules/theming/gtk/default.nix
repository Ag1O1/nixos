{pkgs, inputs, ...}:
let 
  gruvboxplus = import ./gruvbox-plus.nix {inherit pkgs;};
in {
  imports = [./css.nix];
  
  programs.dconf.enable = true;
  hm = {
    gtk = {
      enable = true;

      cursorTheme.package = pkgs.bibata-cursors;
      cursorTheme.name = "Bibata-Modern-Ice";

      theme.package = pkgs.gruvbox-gtk-theme;
      theme.name = "Gruvbox-Dark";
      
      iconTheme.package = gruvboxplus;
      iconTheme.name = "GruvboxPlus";
      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };

      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      gtk.enable = true;
      x11.enable = true;
    };
  };
}

