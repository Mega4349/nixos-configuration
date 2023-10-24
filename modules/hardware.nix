{ pkgs, lib, ... }:

{
  hardware = {
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    opentabletdriver = {
      enable = true;
      daemon.enable = true; 
    };
    openrazer.enable = true;
  };

  environment = {
    # Remove libinput default smoothing for opentabletdriver
    etc."libinput/local-overrides.quirks".text = lib.mkForce ''
      [OpenTabletDriver Virtual Tablets]
      MatchName=OpenTabletDriver*
      AttrTabletSmoothing=0
    '';
 
    systemPackages = with pkgs; [
      openrazer-daemon
      razergenie # GUI for configuring razer devices
      wootility # Wooting keyboard customization software
    ];
  };
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
    EOF
  '';
}
