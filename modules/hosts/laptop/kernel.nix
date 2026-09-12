{
  pkgs,
  lib,
  ...
}: {
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4.extend (
    _lp-self: lp-super: {
      kernel =
        (lp-super.kernel.override {
          modDirVersion = "${lib.head (lib.splitString "-" lp-super.kernel.version)}-Custom";
        }).overrideAttrs
        (old: {
          pname = "linux";
          version = "${lib.head (lib.splitString "-" old.version)}-Custom";
          __intentionallyOverridingVersion = true;
        });
    }
  );
  boot.kernelPatches = [
    # NOTE: This configuration was partly made using claude AI.
    # It would take too much time to configure every single option one by one manually.
    {
      name = "asus-tuf-a16-optimized";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        # ── Version & Identification ──────────────────────────────────────────
        LOCALVERSION = lib.mkForce (freeform "-Custom");
        LOCALVERSION_AUTO = lib.mkForce no;

        # ── Wine/Proton Gaming Features ───────────────────────────────────────
        NTSYNC = module;

        # ── Scheduler & Performance ───────────────────────────────────────────
        SCHED_BORE = yes;
        SCHED_CLASS_EXT = yes;
        PREEMPT = yes;
        PREEMPT_DYNAMIC = yes;
        NO_HZ_IDLE = yes;
        #NO_HZ_FULL = no;
        #HZ_1000 = yes;
        #HZ = freeform "1000";

        # ─── AMD Power & Frequency ─────────────────────────────────────────────
        X86_AMD_PSTATE = yes;
        X86_AMD_PSTATE_DEFAULT_MODE = freeform "3";
        AMD_PMC = module;
        X86_AMD_FREQ_SENSITIVITY = module;
        CPU_FREQ_GOV_SCHEDUTIL = yes;

        # ─── Compression ──────────────────────────────────────────────────────
        ZRAM = module;
        CRYPTO_ZSTD = yes;
        CRYPTO_LZ4 = module;
        CRYPTO_LZ4HC = module;
        ZSWAP = yes;
        ZSWAP_DEFAULT_ON = yes;
        ZSWAP_COMPRESSOR_DEFAULT_ZSTD = yes;

        # ─── GPU: AMD ─────────────────────────────────────────────────────────
        DRM = yes;
        DRM_AMDGPU = module;
        DRM_AMDGPU_USERPTR = yes;
        DRM_AMD_DC = yes;
        DRM_AMD_DC_FP = yes;
        HSA_AMD = yes;
        DRM_TTM = yes;

        # ─── Storage ──────────────────────────────────────────────────────────
        BLK_DEV_NVME = module;
        NVME_MULTIPATH = lib.mkForce no;
        BTRFS_FS = yes;
        BTRFS_FS_POSIX_ACL = yes;
        EXT4_FS = yes;
        EXT4_FS_POSIX_ACL = yes;
        SATA_AHCI = module;
        BLK_DEV_SD = module;

        # ─── Network: Realtek RTL8852CE ───────────────────────────────────────
        R8169 = module;
        WLAN_VENDOR_REALTEK = yes;
        RTW89 = module;
        RTW89_CORE = module;
        RTW89_PCI = module;
        MAC80211 = module;
        CFG80211 = module;
        RFKILL = yes;
        TUN = module;

        # ─── Bluetooth (Realtek combo) ────────────────────────────────────────
        BT = module;
        BT_BREDR = yes;
        BT_LE = yes;
        BT_HCIBTUSB = module;
        BT_RTL = module;

        # ─── Sound & USB ──────────────────────────────────────────────────────
        SND_HDA_INTEL = module;
        SND_HDA_CODEC_REALTEK = module;
        SND_HDA_CODEC_HDMI = module;
        SND_USB_AUDIO = module;
        USB_XHCI_HCD = module;
        USB_XHCI_PCI = module;
        USB_ACM = module;

        # ─── HID / Input ──────────────────────────────────────────────────────
        USB_HID = module;
        HID_GENERIC = module;
        HID_LOGITECH = module;
        HID_LOGITECH_DJ = module;
        HID_LOGITECH_HIDPP = module;

        # ─── ASUS Laptop & Sensors ────────────────────────────────────────────
        SENSORS_K10TEMP = module;
        SENSORS_NCT6775 = module;
        ASUS_WMI = module;
        ASUS_NB_WMI = module;
        ASUS_LAPTOP = module;
        I2C_PIIX4 = module;
        I2C_CHARDEV = module;

        # ═══════════════════════════════════════════════════════════════════════
        # DISABLE EVERYTHING NOT NEEDED
        # ═══════════════════════════════════════════════════════════════════════

        # CPU vendors (AMD only)
        CPU_SUP_INTEL = lib.mkForce no;
        CPU_SUP_HYGON = lib.mkForce no;
        CPU_SUP_CENTAUR = lib.mkForce no;
        CPU_SUP_ZHAOXIN = lib.mkForce no;

        # Graphics (No Intel/NVIDIA open-source)
        DRM_AMDGPU_SI = lib.mkForce no;
        DRM_AMDGPU_CIK = lib.mkForce no;
        DRM_I915 = lib.mkForce no;
        DRM_NOUVEAU = lib.mkForce no;
        DRM_RADEON = lib.mkForce no;
        DRM_VIRTIO_GPU = lib.mkForce no;

        # Virtualization (keep KVM AMD only)
        XEN = lib.mkForce no;
        HYPERV = lib.mkForce no;
        HYPERVISOR_GUEST = lib.mkForce no;
        KVM_INTEL = lib.mkForce no;

        # Enterprise & Server Networking
        NET_VENDOR_INTEL = lib.mkForce no;
        NET_VENDOR_BROADCOM = lib.mkForce no;
        NET_VENDOR_MELLANOX = lib.mkForce no;
        NET_VENDOR_QLOGIC = lib.mkForce no;
        NET_VENDOR_CHELSIO = lib.mkForce no;
        NET_VENDOR_CISCO = lib.mkForce no;
        NET_VENDOR_EMULEX = lib.mkForce no;
        NET_VENDOR_SUN = lib.mkForce no;
        NET_VENDOR_AMAZON = lib.mkForce no;
        NET_VENDOR_GOOGLE = lib.mkForce no;
        NET_VENDOR_MICROSOFT = lib.mkForce no;

        # WiFi vendors (keep Realtek only)
        WLAN_VENDOR_INTEL = lib.mkForce no;
        WLAN_VENDOR_BROADCOM = lib.mkForce no;
        WLAN_VENDOR_ATH = lib.mkForce no;
        WLAN_VENDOR_MARVELL = lib.mkForce no;
        WLAN_VENDOR_MEDIATEK = lib.mkForce no;
        WLAN_VENDOR_TI = lib.mkForce no;
        WLAN_VENDOR_RSI = lib.mkForce no;
        WLAN_VENDOR_ZYDAS = lib.mkForce no;

        # ─── Webcam & Virtual Camera Support ───────────────────────────────────
        SND_SOC = module;
        MEDIA_SUPPORT = module;
        MEDIA_CAMERA_SUPPORT = yes;
        VIDEO_DEV = module;
        MEDIA_CONTROLLER = yes;
        VIDEOBUF2_CORE = module;
        VIDEOBUF2_V4L2 = module;
        VIDEOBUF2_MEMOPS = module;
        VIDEOBUF2_VMALLOC = module;
        USB_VIDEO_CLASS = module;

        # Enterprise Storage
        INFINIBAND = lib.mkForce no;
        FCOE = lib.mkForce no;
        SCSI_AACRAID = lib.mkForce no;
        SCSI_MEGARAID_SAS = lib.mkForce no;
        SCSI_UFSHCD = lib.mkForce no;
        FUSION = lib.mkForce no;

        # Legacy buses & peripherals
        FIREWIRE = lib.mkForce no;
        PCCARD = lib.mkForce no;
        ISDN = lib.mkForce no;
        HAMRADIO = lib.mkForce no;
        CAN = lib.mkForce no;
        NFC = lib.mkForce no;
        ATM = lib.mkForce no;
        MTD = lib.mkForce no;
        IIO = lib.mkForce no;
        STAGING = lib.mkForce no;
        COMEDI = lib.mkForce no;
        RAPIDIO = lib.mkForce no;

        # Legacy USB (keep XHCI only)
        USB_OHCI_HCD = lib.mkForce no;
        USB_UHCI_HCD = lib.mkForce no;
        USB_EHCI_HCD = lib.mkForce no;

        # Other laptop brands (keep ASUS only)
        X86_PLATFORM_DRIVERS_DELL = lib.mkForce no;
        X86_PLATFORM_DRIVERS_HP = lib.mkForce no;
        ACER_WMI = lib.mkForce no;
        SAMSUNG_LAPTOP = lib.mkForce no;
        GIGABYTE_WMI = lib.mkForce no;
        CHROME_PLATFORMS = lib.mkForce no;

        # Legacy filesystems
        XFS_FS = lib.mkForce no;
        JFS_FS = lib.mkForce no;
        GFS2_FS = lib.mkForce no;
        OCFS2_FS = lib.mkForce no;
        NILFS2_FS = lib.mkForce no;
        F2FS_FS = lib.mkForce no;
        CIFS = lib.mkForce no;
        NFS_FS = lib.mkForce no;
        ADFS_FS = lib.mkForce no;
        HFS_FS = lib.mkForce no;
        HFSPLUS_FS = lib.mkForce no;
        UDF_FS = lib.mkForce no;

        # Sensor drivers (keep AMD/NCT6775 only)
        SENSORS_APPLESMC = lib.mkForce no;
        SENSORS_CORETEMP = lib.mkForce no;
        SENSORS_IT87 = lib.mkForce no;
        INTEL_RAPL = lib.mkForce no;
        INTEL_POWERCLAMP = lib.mkForce no;
        INTEL_IDLE = lib.mkForce no;

        # Intel hardware
        INTEL_MEI = lib.mkForce no;
        INTEL_MEI_ME = lib.mkForce no;
        INTEL_TH = lib.mkForce no;
        INTEL_TDX_GUEST = lib.mkForce no;

        # Debug & Tracing (disables for performance)
        DEBUG_INFO_BTF = yes;
        DEBUG_FS = yes;
        DEBUG_KERNEL = lib.mkForce no;
        DEBUG_INFO = lib.mkForce no;
        DYNAMIC_DEBUG = lib.mkForce no;
        SCHEDSTATS = lib.mkForce no;
        LOCKUP_DETECTOR = lib.mkForce no;
        DETECT_HUNG_TASK = lib.mkForce no;
        FTRACE = lib.mkForce no;
        KPROBES = lib.mkForce no;
        UPROBES = lib.mkForce no;
        MAGIC_SYSRQ = yes;
        SLUB_DEBUG = lib.mkForce no;
        KFENCE = lib.mkForce no;
        PRINTK_TIME = lib.mkForce no;

        # Some extra stuff
        USB4 = module;
        THUNDERBOLT = module;
        TYPEC_UCSI = module;
        UCSI_ACPI = module;
        AMD_XDNA = module;
        SND_SOC_AMD_PS = module;
        RTW89_8852CE = module;
        ASUS_ARMOURY = module;
        CRYPTO_DEV_CCP = yes;
        CRYPTO_DEV_SP_PSP = yes;
      };
    }
  ];
}
