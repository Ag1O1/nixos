{config, ...}: {
  services.searx = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        port = 8081;
        bind_address = "127.0.0.1";
        secret_key = config.sops.secrets.searxng_key.path;
      };
      engines = [
        {
          name = "google";
          engine = "google";
          shortcut = "go";
          disabled = false;
        }
        {
          name = "duckduckgo";
          engine = "duckduckgo";
          shortcut = "ddg";
          disabled = false;
        }
        {
          name = "brave";
          engine = "brave";
          shortcut = "br";
          disabled = false;
        }
      ];
      search = {
        formats = ["html" "json"];
      };
    };
  };
}
