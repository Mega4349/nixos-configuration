{ inputs, ... }: 

{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  #TODO move to a file per host
  environment.etc.machine-id.text = ''bd635cdcb4bd4966a44bbb365423e654'';

  environment.persistence."/nix/persist" = {
    hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections"
      ];

      files = [
      #  "/etc/machine-id"
      ];

    users.mega = {
      directories = [
        "Downloads"
        "Pictures"
        "Music"
        "Videos"
        "Documents" 
        "VMs"
        "Projects" 
        
        ".cache"
        ".mozilla"
        ".thunderbird"
        ".config/discordcanary"
        ".config/discord"
	      #".config/dconf"
	      ".config/transmission"
	      ".config/OpenTabletDriver"
 
        ".local/share/flatpak"
	      ".local/share/nvim"
	      ".local/share/PrismLauncher"
        ".local/share/mpd"

        ".local/state/nvim"
        ".local/state/wireplumber"

        ".zsh"
        ".stepmania-5.1"
        "nix-flake"
      
        ".local/share/Steam"
        ".osu"
        ".minecraft"
      ];
      files = [
      ];
    };
  };
}
