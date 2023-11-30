{ pkgs, inputs, ... }:
 
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.nur.nixosModules.nur
    inputs.aagl.nixosModules.default
    #inputs.sops-nix.nixosModules.sops
    ./hardware-configuration.nix
    #import modules from the modules directory
    ../../modules/bootloader.nix
    ../../modules/fonts.nix
    ../../modules/greet.nix
    ../../modules/hardware.nix #partially move to this file, some things will stay consistent
    #../../modules/kernel.nix
    ../../modules/nix.nix
    ../../modules/packages.nix #move to this file, maybe
    #../../modules/persistence.nix #move to this file
    ../../modules/services.nix
    #../../modules/stylix.nix
    ../../modules/users.nix
    ../../modules/virtualisation.nix #add stuff
  ];

  environment = {
    systemPackages = [
      pkgs.lact
    ];
    persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections"
        "/etc/lact"
        #"/var/log"
        "/var/lib/flatpak"
        "/var/lib/libvirtd"
        "/var/lib/libvirt"
        "/var/cache/libvirt"
      ];
      files = [
        #"/etc/machine-id"
      ];
    };
  };

  systemd.services.lactd.enable = true;

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
