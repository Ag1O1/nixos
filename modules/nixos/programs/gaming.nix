{
  inputs,
  fm,
  cm,
  pkgs,
  ...
}: {
  imports = [cm.steam fm.gamemode];
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
  environment.systemPackages = [
    pkgs.prismlauncher # Minecraft
    pkgs.appimage-run
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
