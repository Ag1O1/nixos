{pkgs, inputs, config, lib,...}:
with lib; let
  cfg = config.modules.programs.nvf;
  colors = config.colorScheme.palette;
in {
  imports = [ inputs.nvf.nixosModules.default ];
  options.modules.programs.nvf = {
    enable = lib.mkEnableOption "nvf (neovim)";
  };
  config = mkIf cfg.enable {
    
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
            nix.lsp.enable = true;
            ts.enable = true;
            ts.lsp.enable = true;
            markdown.enable = true;
          };
        };
      };
    };
  };
}