{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    tree
    vim
    wget
    git
    gh
    ngrok
    unrar
    #lime3ds fails to build
    hplip
    godot_4
    (blender.override {
      cudaSupport = true;
    })
    ryujinx
    tofi
    alacritty
    hyprpaper
    slurp
    grim
    imagemagick
    wl-clipboard
    swappy
    cbonsai
    gimp
    kdePackages.wacomtablet
    libsForQt5.dolphin
    nautilus #file manager
    pavucontrol
    spotify
    qbittorrent
    libsForQt5.ark
    telegram-desktop
    bc
    minesweep-rs
    protonplus
    bottles
    fzf
    atuin
    dust
    btop
    bat
    tldr
    eza
    virtualbox

    vscode
    thunderbird
    vesktop
    ungoogled-chromium
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

    nerdfonts
    # Hyprland stuff
    kdePackages.qtwayland
    libsForQt5.qt5.qtwayland
  ];
  fonts.packages = with pkgs; [
    nerdfonts
    cascadia-code
  ];
}