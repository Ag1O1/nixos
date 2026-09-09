{
  pkgs,
  lib,
  ...
}: {
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
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
  environment.shellAliases = {
    nsearch = "nix search nixpkgs";
    grep = "grep --color=auto";
    ls = "${lib.getExe pkgs.eza} --icons=always";
    ll = "${lib.getExe pkgs.eza} --icons=always --long";
    la = "${lib.getExe pkgs.eza} --icons=always --long --all";
    lt = "${lib.getExe pkgs.eza} --icons=always --tree";
  };
}
