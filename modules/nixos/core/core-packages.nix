{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    microfetch
    git
    tree
    vim
    wget
    unzip
  ];
}
