{ pkgs, inputs, ... }:
 
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.nur.nixosModules.nur
    inputs.aagl.nixosModules.default

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
				"/var/cache/regreet"
      ];
    };
  };

  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    honkers-railway-launcher.enable = true;
  };

  # Set hostname
  networking = {
    wireless.enable = false;
    hostName = "nixos-desktop";
  };
}
