{pkgs, ...}: {
  services = {
    ollama = {
      enable = true;
      openFirewall = true;
      package = pkgs.ollama-cuda;
    };
  };

  custom.persist.directories = [
    "/var/lib/private/ollama"
  ];
}
