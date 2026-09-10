{fm, ...}: {
  imports = [fm.android];
  virtualisation.android.enable = true;

  custom.persist.directories = [
    "/var/lib/waydroid"
  ];
}
