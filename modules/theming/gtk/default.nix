{
  pkgs,
  inputs,
  lib,
  ...
}:
/*let
  gruvboxplus = import ./gruvbox-plus.nix { inherit pkgs; };
in*/
{
  imports = [ ./css.nix ];

  programs.dconf.enable = true;
  hm = {
    gtk = {
      enable = true;
      
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      theme = {
        package = pkgs.catppuccin-gtk.override {
          variant = "mocha";
          size = "standard";
          accents = [ "green" ];
          tweaks = [ "normal" ];
        };
        name = "catppuccin-mocha-green-standard+normal";
      };
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "green";
          flavor = "mocha";
        };
        name = "Papirus-Dark";
      };
      gtk2 = {
        extraConfig = ''
          gtk-xft-antialias=1
          gtk-xft-hinting=1
          gtk-xft-hintstyle="hintslight"
          gtk-xft-rgba="rgb"
        '';
      };

      gtk3.extraConfig = {
        # Lets be easy on the eyes. This should be easy to make dependent on
        # the "variant" of the theme, but I never use a light theme anyway.
        gtk-application-prefer-dark-theme = true;

        # Decorations
        gtk-decoration-layout = "appmenu:none";
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = 1;
        gtk-menu-images = 1;

        # Silence bells and whistles, quite literally.
        gtk-error-bell = 0;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;

        # Fonts
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
      };

      gtk4.extraConfig = {
        # Prefer dark theme.
        gtk-application-prefer-dark-theme = true;

        # Decorations.
        gtk-decoration-layout = "appmenu:none";

        # Sounds, again.
        gtk-error-bell = 0;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;

        # Fonts, you know the drill.
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
      };
    };
    
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      gtk.enable = true;
      x11.enable = true;
      size = 24;
    };
  };
}
