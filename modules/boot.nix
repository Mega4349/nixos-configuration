{ config, ... }:
 
{
  boot = {
    plymouth.enable = true;
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 24;
      };
      efi = {
        canTouchEfiVariables = true; 
      };
    };
  };
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
  environment.persistence."/nix/persist".directories = [
    "/var/lib/AccountsService/users"
  ];
}
