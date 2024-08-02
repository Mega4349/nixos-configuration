{ pkgs, inputs, ... }:
 
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.nur.nixosModules.nur

    ./hardware-configuration.nix
  	../../modules
	];

  environment = {
    persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/libvirtd"
        "/var/lib/libvirt"
        "/var/cache/libvirt"
        "/var/lib/waydroid"
      ];
    };
  };

  # Set hostname
  networking.hostName = "nixos-desktop";
}
