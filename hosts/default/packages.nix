{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    tree
    vim
    wget
    git
    gh
    ngrok
    unrar
    lime3ds
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
    pavucontrol
    spotify
    qbittorrent
    libsForQt5.ark
    telegram-desktop
    bc

    vscode
    thunderbird
    vesktop
    ungoogled-chromium
    google-chrome
    microfetch
    obsidian
    prismlauncher

    nerdfonts
  ];
  fonts.packages = with pkgs; [
    nerdfonts
    cascadia-code
  ];
}