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
    ../../modules/kernel.nix
    ../../modules/nix.nix
    ../../modules/packages.nix #move to this file, maybe
    #../../modules/persistence.nix #move to this file
    ../../modules/services.nix
    #../../modules/stylix.nix
    ../../modules/users.nix
    ../../modules/virtualisation.nix #add stuff
  ];

  programs.honkers-railway-launcher.enable = true;

  environment.systemPackages = with pkgs; [ 
    #distrobox 
    #docker 
    neofetch
    ];

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      #"/var/log"
      "/var/lib/libvirtd"
      "/var/lib/libvirt"
      "/var/cache/libvirt"
    ];
    files = [
      #"/etc/machine-id"
    ];
    #users.mega = {
    #  directories = [
    #    "Desktop"
    #    "Downloads"
    #    "Pictures"
    #    "Music"
    #    "Videos"
    #    "Documents" 
    #    "VMs"
    #    "Projects" 
        
    #     ".cache"
    #    ".mozilla"
    #    ".thunderbird"
    #    ".config/discordcanary"
    #    ".config/discord"
    #    ".config/blender"
    #    ".config/obs-studio"
    #    ".config/dconf"
  #	      ".config/transmission"
  #	      ".config/OpenTabletDriver"
  #	".config/zsh"         

   #     #".local/share/flatpak"
   #     ".local/share/Steam"
   #     ".local/share/osu"
   #     ".local/share/nvim"
  #	      ".local/share/mpd"

  #	      ".local/share/PrismLauncher"

   #     ".local/state/nvim"
   #     ".local/state/wireplumber"
   #     ".local/state/home-manager"
   #     ".local/state/nix"

        #".zsh"
   #     ".stepmania-5.1"
   #     "nix-flake"
        
        #".osu"
        #home manager profile?
        #obs, osu lazer, blender
  #    ];
  #    files = [
  #      ""
  #    ];
  #  };
  };

  programs.dconf.enable = true;
  programs.fuse.userAllowOther = true;
  # Set hostname
  networking = {
    hostName = "nixos-desktop";
  };
}
