{ pkgs, lib, ... }:

{
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    opentabletdriver = {
      enable = true;
      daemon.enable = true; 
    };
  };

  # Thunderbolt service
  services.hardware.bolt.enable = true;

  environment = {
    #Remove libinput default smoothing for opentabletdriver
    etc."libinput/local-overrides.quirks".text = lib.mkForce ''
      [OpenTabletDriver Virtual Tablets]
      MatchName=OpenTabletDriver*
      AttrTabletSmoothing=0
    '';
  };

  #udev rules for wootility access to my keyboard, https://help.wooting.io/article/147-configuring-device-access-for-wootility-under-linux-udev-rules
  services.udev.extraRules = ''
    # Wooting 60HE (ARM)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1310", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1310", MODE="0660", TAG+="uaccess"
    # Wooting 60HE (ARM) Alt-gamepad mode
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1311", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1311", MODE="0660", TAG+="uaccess"
    # Wooting 60HE (ARM) 2nd Alt-gamepad mode
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1312", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1312", MODE="0660", TAG+="uaccess"

    # Wooting 60HE (ARM) update mode
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="131f", MODE="0660", TAG+="uaccess"

    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="a8f8", ATTRS{idProduct}=="1829", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

    EOF
  '';
}
