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

    vscode
    thunderbird
    vesktop
    ungoogled-chromium
    google-chrome
    microfetch
    obsidian
    atlauncher
  ];
}