{ pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.nur.nixosModules.nur
    #inputs.aagl.nixosModules.default

    #sops-nix.nixosModules.sops
    ./hardware-configuration.nix
    #import modules from the modules directory
    ../../modules/bootloader.nix
    ../../modules/fonts.nix
    ../../modules/greet.nix
    ../../modules/hardware.nix #partially move to this file, some things will stay consistent
   # ../../modules/kernel.nix
    ../../modules/nix.nix
    ../../modules/packages.nix #move to this file, maybe
   # ../../modules/persistence.nix #move to this file
    ../../modules/services.nix
    ../../modules/users.nix
    ../../modules/virtualisation.nix
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

  #hardware.extraPackages = with pkgs; [
  
 #  intel-media-driver
 #   vaapiIntel
    #libvdpau-va-gl whatever
 # ];

  # Set hostname
  networking = {
    wireless.enable = false;
    hostName = "nixos-laptop";
  };
}
