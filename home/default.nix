{ pkgs, inputs, system, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.anyrun.homeManagerModules.default
		../pkgs
		#./modules/config
    ./modules/firefox.nix
    ./modules/anyrun.nix
    ./modules/filemanagers.nix
    ./modules/filemanagers.nix
    ./modules/foot.nix
    ./modules/discord.nix
    ./modules/games.nix #add aagl
    ./modules/gtk.nix
    #./modules/hyprland.nix
    ./modules/media.nix
		./modules/mpv.nix
    ./modules/ncmpcpp.nix #fix mpd not starting
    ./modules/editors.nix
		#./modules/spotify.nix
    ./modules/obs.nix
    ./modules/qt.nix
    ./modules/qtile.nix
    #./modules/river.nix
    ./modules/sway.nix
		./modules/tmux.nix
		./modules/utilities.nix
		./modules/virtualisation.nix
    ./modules/waybar.nix #make vertical waybar
    ./modules/terminal.nix #wezterm or kitty
    ./modules/shell.nix
    ./modules/xdg.nix
  ];

  programs.home-manager.enable = true;

  home = {
    packages = with pkgs; [ 
			inputs.nix-gaming.packages.${pkgs.system}.proton-ge
			gpu-viewer
    ];
    
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
        
        ".config/deluge"
        ".config/danser"
        ".config/heroic"
        ".config/musikcube"
        ".config/transmission"
        ".config/OpenTabletDriver"
        ".config/wootility-lekker"
        ".config/musikcube"
        ".config/VencordDesktop"
        
        ".local/share/danser"
        ".local/share/Steam"
        ".local/share/osu"
        ".local/share/nvim"
        ".local/share/mpd"
        ".local/share/PrismLauncher"
        ".local/share/honkers-railway-launhcer"
        
        ".local/state/flatpak-module"
        ".local/state/nvim"
        ".local/state/wireplumber"
        ".local/state/home-manager"
        ".local/state/nix"
				
				".mpdscribble"
        ".stepmania-5.1"
      ];
      files = [
      ];
    };
    stateVersion = "23.05";
  };

	programs.git = {
    enable = true;
		package = pkgs.gitFull;
    userName  = "Mega4349";
    userEmail = "elliot.mortberg@gmail.com";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };

    overlays = [
      (final: prev: {
        xwayland = prev.xwayland.overrideAttrs (o: {
          patches = (o.patches or []) ++ [
            ../modules/files/xwayland-vsync.diff
          ];
        });
      })
    ];
  };
}
