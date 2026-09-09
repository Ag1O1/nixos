{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.custom.persist;
  inherit (lib.options) mkOption;
  inherit (lib.types) listOf anything;
in {
  imports = [inputs.preservation.nixosModules.default];
  options.custom.persist = {
    files = mkOption {
      type = listOf anything;
      default = [];
      description = "Files to persist";
    };
    directories = mkOption {
      type = listOf anything;
      default = [];
      description = "Directories to persist";
    };
  };
  config = {
    preservation = {
      enable = true;
      preserveAt."/persistent" = {
        files =
          [
            {
              file = "/etc/machine-id";
              inInitrd = true;
              how = "symlink";
            }
          ]
          ++ cfg.files;
        directories =
          [
            "/var/lib/nixos"
            "/var/lib/systemd/timers"
            "/var/lib/bluetooth"
            "/var/log"
            "/etc/ssh"
          ]
          ++ cfg.directories;
      };
    };
  };
}
