{ pkgs, hm, config, lib, ... }:
with lib; let
  cfg = config.modules.programs.vm;
in {
  options.modules.programs.vm = {
    enable = lib.mkEnableOption "Virtual Machine";
  };
  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };

    environment.systemPackages = with pkgs; [
      spice
      spice-gtk
      spice-protocol
      virt-viewer
      #virtio-win
      #win-spice
    ];
    programs.virt-manager.enable = true;

    hm = {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
      };
    };
  };
}