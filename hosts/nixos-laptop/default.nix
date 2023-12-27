{ pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    #inputs.aagl.nixosModules.default

    ./hardware-configuration.nix
		../../modules
  ];
  
  # For controlling screen brightness
  programs = {
    light.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
  };

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
    ];
  };

  # Set hostname
  networking = {
    wireless.enable = false;
    hostName = "nixos-laptop";
  };
}
