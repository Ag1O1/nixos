{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    #self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim
    wlr-randr
    calibre
    piper
    gparted
    comma
    wl-mirror
    jq
    arduino
    arduino-cli
    arduino-ide
    inkscape
    eden
    rar
    ryubing
    kdePackages.kdenlive
    zathura #PDF viewer
    qimgv #image viewer
    gimp
    audacity
    resources
    onlyoffice-desktopeditors
    motrix-next

    dolphin-emu
    proton-vpn
    mpv
    gnome-calendar
    equibop
    pavucontrol
    file-roller
    btrfs-progs
    bitwarden-desktop
    zed-editor
    zed-discord-presence
    btop
    (nemo-with-extensions.override {
      extensions = with pkgs; [nemo-fileroller];
    })
    godot
    netcat # for godot zed
    blender
    ghostty
    bibata-cursors
  ];
  fonts.packages = with pkgs; [
    wineWow64Packages.fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    corefonts
    vista-fonts
    unifont
    cascadia-code
    fira-code
    fira-sans
    inter
    roboto-serif
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
}
