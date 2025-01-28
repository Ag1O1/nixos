{...}: {
  boot.supportedFilesystems = ["ntfs"];
  fileSystems."/run/media/amr/Disk" = {
    device = "/dev/disk/by-uuid/C0C8B459C8B45000";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };
}
