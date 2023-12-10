{ pkgs, inputs, system, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.anyrun.homeManagerModules.default
    #./modules/eww.nix #use eww only for logout menu, maybe
    ./modules/firefox.nix
    ./modules/anyrun.nix
    #./modules/danser.nix
    ./modules/filemanagers.nix # fix thunar configurations
    ./modules/filemanagers.nix
    ./modules/foot.nix
    #./modules/flatpaks.nix
    ./modules/discord.nix
    ./modules/games.nix #add aagl
    ./modules/gtk.nix
    #./modules/hyprland.nix
    ./modules/media.nix
    ./modules/ncmpcpp.nix #fix mpd not starting
    ./modules/editors.nix
    #./modules/packages.nix #combine with productive, add pavucontrol
    ./modules/productive.nix
    ./modules/qt.nix #may not be needed with stylix
    ./modules/qtile.nix
    #./modules/river.nix
    ./modules/sway.nix
    ./modules/waybar.nix #make vertical waybar
    ./modules/terminal.nix #wezterm or kitty
    ./modules/zsh.nix
    #./pkgs
  ];

  programs.home-manager.enable = true;

  home = {
    packages = with pkgs; [ 
      danser
      neofetch
      #watershot
			inputs.nix-gaming.packages.${pkgs.system}.proton-ge
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
        
        ".local/share/flatpak"
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
      inputs.nur.overlay

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

      (self: super: {
        danser = self.callPackage ./pkgs/danser {};
      })
    ];
  };
}
