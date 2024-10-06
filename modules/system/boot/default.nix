{pkgs, ...}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      default = "2";
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };
  };
  boot.plymouth = {
    enable = true;
    # font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    themePackages = [pkgs.catppuccin-plymouth];
    theme = "catppuccin-macchiato";
  };
}