{
  pkgs,
  lib,
  ...
}: let
  package = pkgs.evolutionWithPlugins;
in {
  environment.systemPackages = [package];
  services.dbus.packages = [package];

  finit.services.evolution = {
    description = "ASUS ROG/TUF hardware control daemon";
    runlevels = "2345";
    command = "${lib.getExe' package "evolution"}";
  };
}
