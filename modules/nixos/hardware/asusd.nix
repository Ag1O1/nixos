{
  services.asusd.enable = true;
  custom.persist = {
    files = [
      "/etc/supergfxd.conf"
    ];
    directories = [
      "/etc/asusd"
    ];
  };
}
