{pkgs, config, lib, ...}:

with lib; let
  cfg = config.modules.programs.fuzzel;
in {
  options.modules.programs.fuzzel = {
    enable = lib.mkEnableOption "fuzzel";
  };
  config = mkIf cfg.enable {
    hm.programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "${pkgs.foot}/bin/foot";
          layer = "overlay";
          icon-theme="Papirus-Dark";
          inner-pad = 4;
        };
        colors = {
          background="1e1e2edd";
          text="cdd6f4ff";
          prompt="bac2deff";
          placeholder="7f849cff";
          input="cdd6f4ff";
          match="a6e3a1ff";
          selection="585b70ff";
          selection-text="cdd6f4ff";
          selection-match="a6e3a1ff";
          counter="7f849cff";
          border="a6e3a1ff";
        };
        
      };
    };
  };
}