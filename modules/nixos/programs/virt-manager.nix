{
  flake.modules.nixos.virt-manager = {pkgs, ...}: {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          vhostUserPackages = [pkgs.virtiofsd];
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
    };

    environment.systemPackages = with pkgs; [
      spice
      spice-gtk
      spice-protocol
      virt-viewer
      virglrenderer
      qemu
      quickemu
      guestfs-tools
      libvirt-glib
      virtiofsd
    ];
    programs.virt-manager.enable = true;
    custom.persist.directories = [
      "/var/lib/libvirt"
    ];
  };
}
