{ lib, osConfig, pkgs, inputs, config, ... }:

{
  home = {
    packages = let 
      games = inputs.nix-gaming.packages.${"x86_64-linux"};
    in [
      pkgs.prismlauncher
  	  pkgs.heroic
      pkgs.stepmania
  	  games.osu-lazer-bin
		  pkgs.steamtinkerlaunch
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
}
