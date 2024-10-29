{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.system.hardware.printing;
in
{
  options.modules.system.hardware.printing = {
    enable = lib.mkEnableOption "printing";
  };
  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
  };
}
