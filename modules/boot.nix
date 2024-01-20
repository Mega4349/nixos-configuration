{ lib, config, ... }:
 
{
  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
    };
    efi = {
      canTouchEfiVariables = true; 
    };
  };
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
}
