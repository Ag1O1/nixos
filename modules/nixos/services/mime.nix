{
  config,
  lib,
  ...
}: let
  cfg = config.modules.services.mime;
  inherit (lib.options) mkOption;
  inherit (lib.types) str;
  inherit
    (cfg)
    text
    browser
    pdf
    image
    video
    audio
    svg
    zip
    file-manager
    torrent
    terminal
    ;

  defaultApplications = {
    "text/*" = "${text}.desktop";
    "inode/directory" = "${file-manager}";

    "image/*" = "${image}.desktop";
    "video/*" = "${video}.desktop";
    "audio/*" = "${audio}.desktop";

    "x-scheme-handler/http" = "${browser}.desktop";
    "x-scheme-handler/https" = "${browser}.desktop";
    "x-scheme-handler/magnet" = "${torrent}.desktop";
    "x-scheme-handler/terminal" = "${terminal}.desktop";

    "application/zip" = "${zip}.desktop";
    "application/x-rar-compressed" = "${zip}.desktop";
    "application/x-7z-compressed" = "${zip}.desktop";
    "application/pdf" = "${pdf}.desktop";
    "application/x-blender" = "blender.desktop";
    "application/x-godot-project" = "org.godotengine.Godot4.desktop";

    "image/svg+xml" = "${svg}.desktop";
  };
in {
  config = {
    xdg.mime = {
      enable = true;
      inherit defaultApplications;
    };
    hj.xdg.config.files."mimeapps.list".text = lib.generators.toINI {} {
      "Default Applications" = defaultApplications;
    };
  };
  options.modules.services.mime = {
    enable = lib.mkEnableOption "mime";

    text = mkOption {
      type = str;
      default = "nvim";
      description = "Defines text editor";
    };
    terminal = mkOption {
      type = str;
      default = "ghostty";
      description = "Defines terminal";
    };
    browser = mkOption {
      type = str;
      default = "librewolf";
      description = "Defines browser";
    };
    pdf = mkOption {
      type = str;
      default = "org.pwmt.zathura";
      description = "Defines pdf viewer";
    };
    image = mkOption {
      type = str;
      default = "qimgv";
      description = "Defines image viewer";
    };
    video = mkOption {
      type = str;
      default = "mpv";
      description = "Defines video player";
    };
    audio = mkOption {
      type = str;
      default = video;
      description = "Defines audio player";
    };
    zip = mkOption {
      type = str;
      default = "file-roller";
      description = "Defines zip viewer";
    };
    svg = mkOption {
      type = str;
      default = "org.inkscape.Inkscape.desktop";
      description = "Defines svg editor";
    };
    file-manager = mkOption {
      type = str;
      default = "nemo";
      description = "Defines file manager";
    };
    torrent = mkOption {
      type = str;
      default = "MotrixNext";
      description = "Defines torrent/download manager";
    };
  };
}
