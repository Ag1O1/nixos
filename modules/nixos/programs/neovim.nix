{
  inputs,
  pkgs,
  lib,
  ...
}: let
  myNeovim =
    (inputs.nvf.lib.neovimConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        {
          config.vim = {
            extraPackages = [pkgs.gdtoolkit_4];
            viAlias = true;
            vimAlias = true;
            debugMode = {
              enable = false;
              level = 16;
              logFile = "/tmp/nvim.log";
            };
            diagnostics = {
              enable = true;
              nvim-lint = {
                enable = true;
                lint_after_save = true;
                linters_by_ft.gdscript = ["gdlint"];
              };
              presets.cpplint.enable = lib.mkForce false;
              config = {
                virtual_text = false;
                virtual_lines = {
                  current_line = true;
                };
                signs = true;
                underline = true;
              };
            };

            luaConfigRC.myconfig =
              # lua
              ''
                vim.o.timeoutlen = 150
              '';
            luaConfigRC.markdown-indent =
              # lua
              ''
                vim.api.nvim_create_autocmd("FileType", {
                  pattern = "markdown",
                  callback = function()
                    vim.bo.expandtab = true
                    vim.bo.shiftwidth = 2
                    vim.bo.tabstop = 2
                    vim.bo.softtabstop = 2
                  end,
                })
              '';
            options = {
              timeoutlen = 150;
              expandtab = true;
              conceallevel = 2;

              shiftwidth = 2;
              tabstop = 2;
              softtabstop = 2;
            };

            globals.mapleader = " ";
            keymaps = [
              {
                key = "<leader>p";
                mode = "n";
                silent = true;
                action = "<cmd>PasteImage<cr>";
              }
              {
                key = "<M-k>";
                mode = "n";
                silent = true;
                action = ":BufferLineCycleNext<CR>";
              }
              {
                key = "<M-j>";
                mode = "n";
                silent = true;
                action = ":BufferLineCyclePrev<CR>";
              }
              {
                key = "<leader>bd";
                mode = "n";
                silent = true;
                action = ":BufferLinePickClose<CR>";
              }

              {
                key = "<leader>bo";
                mode = "n";
                silent = true;
                action = ":BufferLineCloseOthers<CR>";
              }

              {
                key = "<leader>bl";
                mode = "n";
                silent = true;
                action = ":BufferLineCloseLeft<CR>";
              }

              {
                key = "<leader>br";
                mode = "n";
                silent = true;
                action = ":BufferLineCloseRight<CR>";
              }

              {
                key = "<leader>bp";
                mode = "n";
                silent = true;
                action = ":BufferLinePick<CR>";
              }

              {
                key = "<leader>a";
                mode = "n";
                silent = true;
                action = ":Neotree<CR>";
              }
              {
                key = "<leader>e";
                mode = "n";
                action = ":Neotree toggle<CR>";
              }
              {
                key = "<leader>j";
                mode = "n";
                silent = true;
                action = ":CellularAutomaton make_it_rain<CR>";
              }
              {
                key = "<leader>k";
                mode = "n";
                silent = true;
                action = ":CellularAutomaton scramble<CR>";
              }
              {
                key = "<leader>u";
                mode = "n";
                silent = true;
                action = ":CellularAutomaton game_of_life<CR>";
              }
              {
                key = "<leader>i";
                mode = "n";
                silent = true;
                action = ":CellularAutomaton slide<CR>";
              }
              {
                key = "<leader>ca";
                mode = "n";
                silent = true;
                action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
              }
            ];
            clipboard = {
              enable = true;
              providers.wl-copy.enable = true;
            };

            extraPlugins = {
              nvim-lspconfig = {
                package = pkgs.vimPlugins.nvim-lspconfig;
                setup = ''
                  vim.lsp.enable('gdscript')
                  local gdproject = io.open(vim.fn.getcwd()..'/project.godot', 'r')
                  if gdproject then
                      io.close(gdproject)
                      vim.fn.serverstart('./godothost')
                  end
                '';
              };
            };

            lsp = {
              # This must be enabled for the language modules to hook into
              # the LSP API.
              enable = true;

              formatOnSave = true;
              lspkind.enable = false;
              lightbulb.enable = false;
              lspsaga.enable = false;
              trouble.enable = true;
              otter-nvim.enable = true;
            };

            debugger = {
              nvim-dap = {
                enable = true;
                ui.enable = true;
              };
            };

            formatter.conform-nvim = {
              enable = true;
              setupOpts = {
                formatters_by_ft.gdscript = ["gdformat"];
                formatters.gdformat = {
                  command = "gdformat";
                  args = ["-"]; # read from stdin, write to stdout
                  stdin = true;
                };
                formatters.rumdl.append_args = [
                  "--config"
                  "MD013.line-length=80"

                  "--config"
                  "MD013.reflow=true"

                  "--config"
                  "MD007.indent=2"
                ];
              };
            };

            # This section does not include a comprehensive list of available language modules.
            # To list all available language module options, please visit the nvf manual.
            languages = {
              enableFormat = true;
              enableTreesitter = true;
              enableExtraDiagnostics = true;

              # Languages that will be supported in default and maximal configurations.
              nix = {
                enable = true;
                lsp.servers = ["nixd"];
              };
              markdown = {
                enable = true;
                extensions = {
                  render-markdown-nvim.enable = true;
                };
                format.type = ["rumdl" "injected"];
              };
              # Languages that are enabled in the maximal configuration.
              bash.enable = true;
              clang.enable = true;
              cmake.enable = true;
              css.enable = true;
              html.enable = true;
              json.enable = true;
              sql.enable = true;
              java.enable = true;
              kotlin.enable = true;
              go.enable = true;
              lua.enable = true;
              zig.enable = true;
              python.enable = true;
              typst.enable = true;
              rust = {
                enable = true;
                extensions.crates-nvim.enable = true;
              };
              toml.enable = true;
              assembly.enable = true;

              # Language modules that are not as common.
              openscad.enable = false;
              arduino.enable = false;
              astro.enable = false;
              nu.enable = false;
              csharp.enable = false;
              julia.enable = false;
              vala.enable = false;
              scala.enable = false;
              r.enable = false;
              gleam.enable = false;
              glsl.enable = false;
              dart.enable = false;
              ocaml.enable = false;
              elixir.enable = false;
              haskell.enable = false;
              hcl.enable = false;
              ruby.enable = false;
              fsharp.enable = false;
              just.enable = false;
              make.enable = false;
              qml.enable = false;
              jinja.enable = false;
              svelte.enable = false;
              liquid.enable = false;
              tera.enable = false;
              twig.enable = false;
              gettext.enable = false;
              fluent.enable = false;
              jq.enable = false;
              nim.enable = false;
            };

            visuals = {
              nvim-scrollbar.enable = true;
              nvim-web-devicons.enable = true;
              nvim-cursorline.enable = true;
              cinnamon-nvim.enable = true;
              fidget-nvim.enable = true;

              highlight-undo.enable = true;
              blink-indent.enable = true;
              indent-blankline.enable = false; #conflicts with blink

              # Fun
              cellular-automaton.enable = true;
            };

            statusline = {
              lualine = {
                enable = true;
                theme = "auto";
              };
            };

            theme = {
              enable = true;
              name = "catppuccin";
              style = "mocha";
              transparent = true;
            };

            autopairs.nvim-autopairs.enable = true;

            # nvf provides various autocomplete options. The tried and tested nvim-cmp
            # is enabled in default package, because it does not trigger a build. We
            # enable blink-cmp in maximal because it needs to build its rust fuzzy
            # matcher library.
            autocomplete = {
              blink-cmp = {
                enable = true;
                setupOpts = {
                  sources.default = [
                    "lsp"
                    "path"
                    "snippets"
                  ];
                  completion = {
                    list = {
                      selection = {
                        preselect = false;
                        auto_insert = false;
                      };
                    };
                  };
                };
              };
            };

            snippets.luasnip.enable = true;

            filetree = {
              neo-tree = {
                enable = true;
              };
            };

            tabline = {
              nvimBufferline.enable = true;
            };

            treesitter.context.enable = true;

            binds = {
              whichKey.enable = true;
              cheatsheet.enable = true;
            };

            telescope.enable = true;

            git = {
              enable = true;
              gitsigns = {
                enable = true;
                setupOpts = {
                  current_line_blame = true;
                  current_line_blame_opts = {
                    delay = 300;
                  };
                };
              };
              neogit.enable = true;
            };

            #minimap = {
            #minimap-vim.enable = false;
            #codewindow.enable = false; # lighter, faster, and uses lua for configuration
            #};

            dashboard = {
              dashboard-nvim.enable = false;
              alpha.enable = true;
            };

            notify = {
              nvim-notify.enable = true;
            };

            projects = {
              project-nvim.enable = true;
            };

            utility = {
              ccc.enable = false;
              vim-wakatime.enable = false;
              diffview-nvim.enable = true;
              yanky-nvim.enable = false;
              qmk-nvim.enable = false; # requires hardware specific options
              icon-picker.enable = false;
              preview.markdownPreview.enable = true;

              motion = {
                hop.enable = false;
                leap.enable = true;
              };
              images = {
                image-nvim = {
                  enable = true;
                  setupOpts.backend = "kitty";
                };
                img-clip.enable = true;
              };
            };

            notes = {
              neorg = {
                enable = true;

                treesitter.enable = true;

                setupOpts = {
                  load = {
                    "core.defaults".enable = true;
                    "core.concealer".enable = true;
                  };
                };
              };
              #orgmode.enable = true;
              todo-comments.enable = true;
            };

            terminal = {
              toggleterm = {
                enable = true;
                lazygit.enable = true;
              };
            };

            ui = {
              borders.enable = true;
              noice.enable = true;
              colorizer.enable = true;
              modes-nvim.enable = false; # the theme looks terrible with catppuccin
              illuminate.enable = true;
              /*
              breadcrumbs = {
                enable = isMaximal;
                navbuddy.enable = isMaximal;
              };
              */
              smartcolumn = {
                enable = true;
                setupOpts.custom_colorcolumn = {
                  # this is a freeform module, it's `buftype = int;` for configuring column position
                  nix = "110";
                  ruby = "120";
                  java = "130";
                  go = ["90" "130"];
                };
              };
              fastaction.enable = true;
            };

            session = {
              nvim-session-manager.enable = false;
            };

            gestures = {
              gesture-nvim.enable = false;
            };

            comments = {
              comment-nvim.enable = true;
            };

            presence = {
              neocord.enable = true;
            };
          };
        }
      ];
    })
      .neovim;
in {
  environment.systemPackages = [myNeovim];
}
