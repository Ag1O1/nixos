{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.bluetooth;
in
{
  options.modules.services.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };
  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
