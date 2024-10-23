{pkgs, inputs, config, lib,...}:
with lib; let
  cfg = config.modules.programs.nvf;
  colors = config.colorScheme.palette;
in {
  options.modules.programs.nvf = {
    enable = lib.mkEnableOption "nvf (neovim)";
  };
  config = mkIf cfg.enable {
    imports = [ inputs.nvf.nixosModules.default ];
    programs.nvf = {
      enable = true;
      # your settings need to go into the settings attribute set
      # most settings are documented in the appendix
      settings = {
        vim = {
          viAlias = false;
          vimAlias = true;
          lsp = {
            enable = true;
          };
          languages = {
            nix.enable = true;
            ts.enable = true;
            markdown.enable = true;
          };
        };
      };
    };
  };
}