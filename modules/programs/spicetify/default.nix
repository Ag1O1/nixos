{lib,config,inputs,pkgs,...}:
with lib; let
  cfg = config.modules.programs.spotify;
in {
  options.modules.programs.spotify = {
    enable = lib.mkEnableOption "spotify";
  };
  config = mkIf cfg.enable {
  programs.spicetify =
   let
     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
   in
   {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
       adblock
       #hidePodcasts
       shuffle # shuffle+ (special characters are sanitized out of extension names)
     ];
     theme = spicePkgs.themes.catppuccin;
     colorScheme = "mocha";
   };
  };
}