{
  flake.modules.nixos.tlp = {lib, ...}: {
    services.power-profiles-daemon.enable = lib.mkForce false;
    services.tlp = {
      enable = true;
      pd.enable = true;
      settings = {
        # General
        NMI_WATCHDOG = 0;
        TLP_DEFAULT_MODE = "BAL";
        TLP_AUTO_SWITCH = 2;
        RUNTIME_PM_DRIVER_DENYLIST = "";

        # Battery Longevity
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;

        # CPU - amd-pstate-epp
        AMD_PSTATE_STATUS = "active";
        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";
        CPU_DRIVER_OPMODE_ON_SAV = "active";

        # Scaling Governor
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_SAV = "powersave";

        # Energy Performance Preference
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_SAV = "power";

        # Boost Control
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_BOOST_ON_SAV = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_SAV = 0;

        # Platform Profiles
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";
        PLATFORM_PROFILE_ON_SAV = "quiet";

        # Graphics
        RADEON_DPM_STATE_ON_AC = "performance";
        RADEON_DPM_STATE_ON_BAT = "battery";
        RADEON_DPM_STATE_ON_SAV = "battery";

        # PCIe
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";
        PCIE_ASPM_ON_SAV = "powersupersave";

        # Runtime PM
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";
        RUNTIME_PM_ON_SAV = "auto";

        # Network
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "off";
        WIFI_PWR_ON_SAV = "off";
        DEVICES_OFF_ON_SAV = "bluetooth wwan";

        # Disk
        SATA_LINKPWR_ON_AC = "med_power_with_dipm";
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
        SATA_LINKPWR_ON_SAV = "min_power";
        AHCI_RUNTIME_PM_ON_SAV = "auto";

        # Scheduler
        SCHED_POWERSAVE_ON_AC = 0;
        SCHED_POWERSAVE_ON_BAT = 1;
        SCHED_POWERSAVE_ON_SAV = 1;

        # Sound
        SOUND_POWER_SAVE_ON_BAT = 1;
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_CONTROLLER = "Y";
      };
    };
  };
}
