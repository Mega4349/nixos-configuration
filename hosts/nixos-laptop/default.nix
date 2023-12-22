{ pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.nur.nixosModules.nur
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
    ];
  };

  # Set hostname
  networking = {
    wireless.enable = false;
    hostName = "nixos-laptop";
  };
}
