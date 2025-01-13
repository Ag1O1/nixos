{ pkgs, stable-pkgs, ... }:
{
  # Packages
  environment.systemPackages = [
    pkgs.tree
    pkgs.vim
    pkgs.wget
    pkgs.git
    pkgs.gh
    pkgs.ngrok
    pkgs.unrar
    #pkgs.mission-center fails to build
    #pkgs.lime3ds fails to build
    pkgs.godot_4
    #pkgs.(blender.override {
    #pkgs.  cudaSupport = true;
    #pkgs.  waylandSupport = true;
    #pkgs.})
    pkgs.blender_4_2
    pkgs.ryujinx
    pkgs.hyprpaper
    pkgs.slurp
    pkgs.grim
    pkgs.cbonsai
    pkgs.gimp
    pkgs.kdePackages.wacomtablet
    pkgs.nautilus # file manager
    pkgs.pavucontrol
    pkgs.qbittorrent
    pkgs.libsForQt5.ark
    pkgs.telegram-desktop
    pkgs.bc
    pkgs.minesweep-rs
    #pkgs.bottles
    pkgs.fzf
    pkgs.atuin
    pkgs.dust
    pkgs.btop
    pkgs.bat
    pkgs.tldr
    pkgs.eza
    pkgs.uget # download manager
    pkgs.scrcpy
    pkgs.nixfmt-rfc-style
    pkgs.libreoffice
    pkgs.simple-scan
    pkgs.gnome-calendar
    #pkgs.equibop
    pkgs.element-desktop
    pkgs.aseprite
    pkgs.kdePackages.kdenlive
    pkgs.zapzap
    pkgs.uget-integrator
    pkgs.gparted
    pkgs.lzip
    pkgs.python3
    pkgs.krita
    pkgs.jre8
    pkgs.jdk8
    pkgs.haxe
    pkgs.retroarchFull
    pkgs.rustc
    pkgs.cargo
    pkgs.gcc
    pkgs.qalculate-gtk
    pkgs.libqalculate

    pkgs.vscode
    pkgs.thunderbird
    pkgs.vesktop
    pkgs.google-chrome
    pkgs.microfetch
    pkgs.obsidian
    pkgs.prismlauncher
    pkgs.obs-studio
    pkgs.vlc
    pkgs.bun
    #pkgs.davinci-resolve
    pkgs.udiskie
    pkgs.gvfs
    pkgs.udisks
    pkgs.usbutils
    pkgs.libwacom

    # stable pkgs
    stable-pkgs.bottles
  ];
  fonts.packages = with pkgs; [
    #nerd-fonts
    cascadia-code
  ];
}
