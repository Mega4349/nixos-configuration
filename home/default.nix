{ pkgs, inputs, ... }:

{
  imports = [
		inputs.impermanence.nixosModules.home-manager.impermanence

		../pkgs
		./modules/wayland
    ./modules/editors

    ./modules/discord.nix
		./modules/filemanagers.nix
    ./modules/firefox.nix
		./modules/games.nix
		./modules/git.nix
    ./modules/kitty.nix
		./modules/mpv.nix
		./modules/nix.nix
		./modules/obs.nix
    ./modules/osu-stable.nix
    ./modules/shell.nix
    ./modules/sound.nix
    ./modules/spotify.nix
    ./modules/theme.nix
		./modules/utilities.nix
		./modules/virtualisation.nix
		./modules/xdg.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "mega";
    homeDirectory = "/home/mega";
    
    persistence."/nix/persist/home/mega" = {
      allowOther = true;
      directories = [
        "Desktop"
        "Downloads"
        "Pictures"
        "Music"
        "Videos"
        "Documents"
        "VMs"
        "Projects"

        ".cache"

        ".ssh"

        ".config/sops"
        
        ".local/state/home-manager"
        ".local/state/nix"
      ];
    };
    stateVersion = "23.05";
  };
}
