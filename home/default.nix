{ pkgs, inputs, system, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.anyrun.homeManagerModules.default
		../pkgs
		./config
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
    ./modules/productive.nix
    ./modules/qt.nix
    ./modules/qtile.nix
    #./modules/river.nix
    ./modules/sway.nix
		./modules/tmux.nix
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
        ".mozilla"
        ".thunderbird"
        
        ".config/deluge"
        ".config/discordcanary"
        ".config/blender"
        ".config/obs-studio"
        ".config/dconf"
        ".config/danser"
        ".config/heroic"
        ".config/musikcube"
        ".config/transmission"
        ".config/OpenTabletDriver"
        ".config/zsh"
        ".config/wootility-lekker"
        ".config/musikcube"
        ".config/nemo"
        ".config/neofetch"
        ".config/VencordDesktop"
        
				".local/share/fish"
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
        ".zsh_history" #zsh command history
        #".config/mimeapps.list"
      ];
    };
    stateVersion = "23.05";
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
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

      #https://github.com/NixOS/nixpkgs/issues/239424
      (final: prev: {
        avidemux = prev.avidemux.overrideAttrs (oldAttrs: {
          buildCommand = oldAttrs.buildCommand + ''
            mv $out/bin/avidemux $out/bin/avidemux3
            echo 'LD_LIBRARY_PATH=$(dirname $(readlink -f $(which avidemux3)))/../lib/ avidemux3 "$@"' >> $out/bin/avidemux
            chmod +x $out/bin/avidemux

            mv $out/bin/avidemux3_cli $out/bin/avidemux3_cli_old
            echo 'LD_LIBRARY_PATH=$(dirname $(readlink -f $(which avidemux3_cli)))/../lib/ avidemux3_cli_old "$@"' >> $out/bin/avidemux3_cli
            chmod +x $out/bin/avidemux3_cli
          '';
        });
      })

			(final: prev: {
  		  ranger-sixel = prev.ranger.overrideAttrs (oldAttrs: {
      		patches = (oldAttrs.patches or [ ]) ++ [
        		(prev.fetchpatch {
          		url = "https://github.com/3ap/ranger/commit/ef9ec1f0e0786e2935c233e4321684514c2c6553.patch";
          		sha256 = "sha256-MJbIBuFeOvYnF6KntWJ2ODQ4KAcbnFEQ1axt1iQGkWY=";
        		})
      		];
    		});
  		})

			# MPV scripts
      (self: super: {
        mpv = super.mpv.override {
          scripts = with self.mpvScripts; 
            [ sponsorblock ]; #mpris thumbnail webtorrent-mpv-hook ];
        };
      })
    ];
  };
}
