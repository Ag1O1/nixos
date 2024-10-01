{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
}