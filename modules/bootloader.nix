{ lib, config, ... }:
 
{
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true; 
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      enableCryptodisk = true;
    };
  };
}
