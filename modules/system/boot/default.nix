{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;
    kernelParams = ["nvidia_drm.fbdev=1"];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        default = "2";
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
      };
    };
    plymouth = {
      enable = true;
      # font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
      themePackages = [pkgs.catppuccin-plymouth];
      theme = "catppuccin-macchiato";
    };
  };
}