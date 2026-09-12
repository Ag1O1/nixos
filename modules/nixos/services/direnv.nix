{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    direnv
    nix-direnv
  ];
  hj.xdg.config.files."fish/conf.d/direnv.fish".text = ''
    ${pkgs.direnv}/bin/direnv hook fish | source
  '';
}
