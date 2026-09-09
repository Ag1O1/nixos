{
  services.openssh.enable = true;
  custom.persist.directories = [
    "/etc/ssh"
  ];
}
