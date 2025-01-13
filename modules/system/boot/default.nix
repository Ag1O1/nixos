{pkgs, ...}:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
  username = "amr";
in

{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };

  boot = {
    #kernelPackages = pkgs.linuxPackages_xanmod_latest;
    #kernelPackages = pkgs.pkgs.linuxPackages_testing;
    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;
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
      themePackages = [pkgs.adi1090x-plymouth-themes];
      theme = "liquid";
    };
  };
}
