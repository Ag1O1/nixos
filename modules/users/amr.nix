{
  inputs,
  self,
  pkgs,
  lib,
  config,
  ...
}: let
  user = "amr";
in {
  imports = [
    inputs.hjem.finixModules.default

    (
      lib.mkAliasOptionModule
      ["hj"]
      [
        "hjem"
        "users"
        "${user}"
      ]
    )
  ];
  users.users = {
    amr = {
      enable = true;
      password = "$y$j9T$Y2uJLXLmZQ4qgcKG2oRCM/$a4YhLj6f6uOC2LZe7md6Mi4rt7spr7bfqed4opRE8J2";
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [
        "seat" # seatd
        "ydotool"
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner" # printer scanner
        "lp"
        "video"
        "kvm"
        "libvirt" # some virtualization thing
        "docker"
        "wireshark" # for wireshark to work
        "dialout" # for arduino to work
      ];
    };
  };
  hj = {
    enable = true;
  };
  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "ghostty";
  };
}
