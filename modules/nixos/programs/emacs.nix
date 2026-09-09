{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    emacs
  ];
  fonts.packages = with pkgs; [
    emacs-all-the-icons-fonts
  ];
  services.emacs = {
    enable = true;
    #defaultEditor = true;
  };
}
