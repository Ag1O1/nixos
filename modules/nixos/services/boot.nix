{fm, ...}: {
  imports = [fm.limine];
  boot.loader.efi.canTouchEfiVariables = true;
  programs.limine = {
    enable = true;
  };
}
