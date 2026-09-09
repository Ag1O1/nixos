{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";
    useSystemdActivation = true;

    gnupg.sshKeyPaths = [];
    age = {
      sshKeyPaths = [];
      keyFile = "/persistent/var/lib/sops-nix/key.txt";
    };
    secrets = {
      searxng_key = {};
      user_pass.neededForUsers = true;
      root_pass.neededForUsers = true;
    };
  };
  users = {
    mutableUsers = false;
    users.root.hashedPasswordFile = config.sops.secrets.root_pass.path;
  };
}
