{
  inputs,
  pkgs,
  system,
  ...
}: let
  pkgsStable = import inputs.nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in {
  programs.appimage.enable = true;
  programs.steam = {
    enable = true;
    package = inputs.millennium.packages."${pkgs.system}".millennium-steam;
    /*
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          # Workaround xorg cursor issue
          bibata-cursors
        ];
    };
    */
  };
  programs.steam.gamescopeSession.enable = true;
  environment.systemPackages = [
    pkgs.prismlauncher # Minecraft
    pkgs.love # to run love2d games
    pkgs.mangohud
    (pkgs.lutris.override {
      # Intercept buildFHSEnv to modify target packages
      buildFHSEnv = args:
        pkgs.buildFHSEnv (args
          // {
            multiPkgs = envPkgs: let
              # Fetch original package list
              originalPkgs = args.multiPkgs envPkgs;

              # Disable tests for openldap
              customLdap = envPkgs.openldap.overrideAttrs (_: {doCheck = false;});
            in
              # Replace broken openldap with the custom one
              builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [customLdap];
          });
    })
    pkgs.umu-launcher
    (pkgs.winePackages.waylandFull.override {wineBuild = "wine64";})
    pkgs.winetricks
  ];

  programs.gamemode.enable = true;
}
