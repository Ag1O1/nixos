{pkgs, ...}: let
  wrappedLogisim = pkgs.symlinkJoin {
    name = "logisim-evolution-wrapped";
    paths = [pkgs.logisim-evolution];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/logisim-evolution \
        --set _JAVA_AWT_WM_NONREPARENTING "1"
    '';
  };
in {
  environment.systemPackages = [wrappedLogisim];
}
