{
  lib,
  fm,
  ...
}: {
  imports = [fm.sudo];
  programs.sudo.enable = true;
  environment.etc.sudoers.text = lib.mkAfter ''
    Defaults lecture=never
  '';
}
