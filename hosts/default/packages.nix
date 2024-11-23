{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree
    vim
    wget
    git
    gh
    ngrok
    unrar
    #mission-center fails to build
    #lime3ds fails to build
    godot_4
    #(blender.override {
    #  cudaSupport = true;
    #  waylandSupport = true;
    #})
    blender_4_2
    ryujinx
    hyprpaper
    slurp
    grim
    cbonsai
    gimp
    kdePackages.wacomtablet
    nautilus # file manager
    pavucontrol
    qbittorrent
    libsForQt5.ark
    telegram-desktop
    bc
    minesweep-rs
    bottles
    fzf
    atuin
    dust
    btop
    bat
    tldr
    eza
    uget # download manager
    scrcpy
    nixfmt-rfc-style
    libreoffice
    simple-scan
    gnome-calendar
    equibop
    element-desktop
    aseprite
    kdePackages.kdenlive
    zapzap
    uget-integrator
    gparted
    lzip
    python3
    krita

    vscode
    thunderbird
    vesktop
    google-chrome
    microfetch
    obsidian
    prismlauncher
    obs-studio
    vlc
    bun
    davinci-resolve
    udiskie
    gvfs
    udisks
    usbutils

  ];
  fonts.packages = with pkgs; [
    nerdfonts
    cascadia-code
  ];

}
