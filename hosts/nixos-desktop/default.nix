{ pkgs, inputs, ... }:
 
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.nur.nixosModules.nur

    ./hardware-configuration.nix
  	../../modules
	];

  services.blueman.enable = true;

  environment = {
    persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections"
        "/etc/ssh"
        "/var/lib/libvirtd"
        "/var/lib/libvirt"
        "/var/cache/libvirt"
      ];
    };
  };

  # Set hostname
  networking.hostName = "nixos-desktop";
}
