{ lib, osConfig, pkgs, inputs, config, ... }:

lib.mkIf (osConfig.networking.hostName == "nixos-desktop") {
  home = { 
		packages = let 
    	games = inputs.nix-gaming.packages.${"x86_64-linux"};
  	in [
    	pkgs.prismlauncher
    
    	pkgs.heroic

    	pkgs.stepmania

    	games.osu-lazer-bin

    	games.wine-discord-ipc-bridge

    	#pkgs.wineWowPackages.staging # Conflicts with osu-wine from nix-gaming
    	pkgs.winetricks
    	pkgs.mono
    	games.wine-osu

			pkgs.steamtinkerlaunch

    	games.osu-stable
  	];
		persistence."/nix/persist/home/mega".directories = [
			".local/share/Steam"
			".local/share/osu"
			".config/heroic"
			".config/OpenTabletDriver"
			".local/share/honkers-railway-launcher"
			".local/share/prismlauncher"
			".stepmania-5.1"
		];
	};
	
	nixpkgs.overlays = [
    (final: prev: {
      xwayland = prev.xwayland.overrideAttrs (o: {
        patches = (o.patches or []) ++ [
          ../../modules/files/xwayland-vsync.diff
        ];
      });
    })
  ];
}
