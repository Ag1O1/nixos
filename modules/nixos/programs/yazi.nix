{pkgs, ...}: {
  environment.systemPackages = [pkgs.yazi];

  /*
  programs.yazi = {
    enable = true;
    plugins = {
      mount = pkgs.yaziPlugins.mount;
      compress = pkgs.yaziPlugins.compress;
    };
  };
  */
}
