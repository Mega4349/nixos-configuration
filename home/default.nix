{ pkgs, inputs, system, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
		../pkgs
		./modules/wayland
		#./modules/config
    ./modules/firefox.nix
    ./modules/filemanagers.nix
    ./modules/filemanagers.nix
    ./modules/foot.nix
    ./modules/discord.nix
    ./modules/games.nix #add aagl
		./modules/git.nix
    ./modules/theme.nix
		./modules/mpv.nix
    ./modules/sound.nix
		./modules/nix.nix
    ./modules/neovim.nix
		#./modules/spotify.nix
    ./modules/obs.nix
		./modules/tmux.nix
		./modules/utilities.nix
		./modules/virtualisation.nix
    #./modules/wezterm.nix
    ./modules/shell.nix
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
        
        ".local/state/home-manager"
        ".local/state/nix"
      ];
    };
    stateVersion = "23.05";
  };
}
