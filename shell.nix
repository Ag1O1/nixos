{pkgs,...}:
pkgs.mkShell
{
  nativeBuildInputs = [
    pkgs.haxe
    pkgs.haxePackages.hxcpp
  ];

  shellHook = ''
    ${pkgs.vscode}
  '';
}