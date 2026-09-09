{pkgs, ...}: let
  toggleTouchpad =
    pkgs.writeShellScript "toggletouchpad" #bash
    
    ''
      #!/bin/bash
      DEVICE="i2c-ASCP1200:00"
      DRIVER_PATH="/sys/bus/i2c/drivers/i2c_hid_acpi"

      if [ -L "/sys/bus/i2c/devices/$DEVICE/driver" ]; then
          echo "$DEVICE" > "$DRIVER_PATH/unbind"
      else
          echo "$DEVICE" > "$DRIVER_PATH/bind"
      fi
    '';
in {
  systemd.services.keyd.serviceConfig = {
    ReadWritePaths = ["/sys/bus/i2c/drivers/i2c_hid_acpi"];
  };
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          capslock = "overload(nav, macro(esc+15ms))";
          "\\" = "backspace";
          backspace = "\\";
          f21 = "command(${toggleTouchpad})";
        };
        "shift:S" = {
          capslock = "capslock";
        };
        "nav" = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          b = "C-left";
          w = "C-right";
          "0" = "home";
          "4" = "end";
          d = "layer(nav_delete)";
          i = "pageup";
          u = "pagedown";
          "\\" = "C-backspace";

          # Cheaty macros for games
          p = "macro(leftmouse+15ms)";
          "[" = "macro(esc 5ms leftmouse+15ms 5ms esc)";
          "]" = "macro(esc 5ms rightmouse+15ms 5ms esc)";
        };
        nav_delete = {
          w = "C-delete";
          b = "C-backspace";
        };
      };
    };
  };
}
