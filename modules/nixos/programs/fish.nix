{
  pkgs,
  lib,
  fm,
  ...
}: {
  imports = [fm.fish];
  programs.fish.enable = true;

  environment.systemPackages = [
    pkgs.fishPlugins.tide
    pkgs.fishPlugins.done
    (pkgs.writers.writeFishBin "nrun" ''
      if echo "$argv[1]" | grep -Eq '^[a-z]+:.+/.+$'
          nix run $argv[1] -- $argv[2..]
      else
          nix run nixpkgs#$argv[1] -- $argv[2..]
      end
    '')
    (pkgs.writers.writeFishBin "nsh" ''
      if echo "$argv[1]" | grep -Eq '^[a-z]+:.+/.+$'
        nix shell $argv[1] -- $argv[2..]
      else
        nix shell nixpkgs#$argv[1] -- $argv[2..]
      end
    '')
    (pkgs.writers.writeFishBin "nedit" ''
      nix edit nixpkgs#$argv[1]
    '')
  ];

  hj.xdg.config.files = {
    "fish/conf.d/init.fish".text = ''
      set fish_greeting # Disable greeting
    '';

    "fish/conf.d/aliases.fish".text = ''
      alias nsearch="nix search nixpkgs"
      alias grep="grep --color=auto"
      alias ls="${lib.getExe pkgs.eza} --icons=always"
      alias ll="${lib.getExe pkgs.eza} --icons=always --long"
      alias la="${lib.getExe pkgs.eza} --icons=always --long --all"
      alias lt="${lib.getExe pkgs.eza} --icons=always --tree"
    '';
  };
}
