{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    plugins = {
      mount = pkgs.yaziPlugins.mount;
      compress = pkgs.yaziPlugins.compress;
    };
  };
}
