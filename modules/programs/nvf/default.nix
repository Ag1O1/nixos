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
      enableManpages = true;
      # your settings need to go into the settings attribute set
      # most settings are documented in the appendix
      settings = {
        vim = {
          viAlias = false;
          vimAlias = true;
          lsp.enable = true;
          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
          theme = {
            enable = true;
            name = "gruvbox";
            style = "dark";
          };

          languages = {
            enableLSP = true;
            enableTreesitter = true;

            nix.enable = true;
            nix.format.enable = true;
            nix.format.type = "nixfmt";
            ts.enable = true;
            rust.enable = true;
            python.enable = true;
            markdown.enable = true;
            
          };
        };
      };
    };
  };
}
