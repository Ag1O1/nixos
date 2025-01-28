{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.tmux;
in {
  options.modules.programs.spotify = {
    enable = lib.mkEnableOption "tmux";
  };
  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      keyMode = "vi";
    };
  };
}
