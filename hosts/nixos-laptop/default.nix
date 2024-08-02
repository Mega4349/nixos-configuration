{ pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    #inputs.aagl.nixosModules.default

    ./hardware-configuration.nix
		../../modules
  ];
  
  # For controlling screen brightness
  programs.light.enable = true;
  services.blueman.enable = true;

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/waydroid"
    ];
  };

  # Set hostname
  networking.hostName = "nixos-laptop";
}
