{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.nvf;
  colors = config.colorScheme.palette;
in {
  imports = [inputs.nvf.nixosModules.default];
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
          keymaps = [
            {
              key = "<SPACE>a";
              mode = "n";
              silent = true;
              action = ":Neotree<CR>";
            }
          ];
          viAlias = false;
          vimAlias = true;
          lsp.enable = true;
          lsp.formatOnSave = true;
          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
          theme = {
            enable = true;
            name = "catppuccin";
            #base16-colors = colors;
            style = "mocha";
          };
          options = {
            expandtab = true;
            shiftwidth = 2;
            tabstop = 2;
            softtabstop = 2;
          };
          filetree.neo-tree = {
            enable = true;
          };
          languages = {
            enableLSP = true;
            enableTreesitter = true;
            enableFormat = true;

            nix = {
              enable = true;
              format.enable = true;
              format.type = "alejandra";
            };
            ts = {
              enable = true;
            };
            rust = {
              enable = true;
            };
            python = {
              enable = true;
            };

            markdown = {
              enable = true;
            };
          };
        };
      };
    };
  };
}
