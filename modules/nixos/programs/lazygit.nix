{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [pkgs.lazygit];
  hj.xdg.config.files."lazygit/config.yml".text = lib.generators.toYAML {} {
    git = {
      autoFetch = false;
    };
  };
}
