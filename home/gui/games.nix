{ pkgs, inputs, ... }:

let
  games = inputs.nix-gaming.packages.${"x86_64-linux"};
in
{
  home = {
    packages = with pkgs; [
      prismlauncher
      jdk8
  	  heroic
      bottles
      steamtinkerlaunch

  	  games.osu-lazer-bin
    ];

	  persistence."/nix/persist/home/mega".directories = [
		  ".local/share/Steam"
		  ".local/share/osu"
      ".local/share/bottles"
		  ".config/heroic"
		  ".config/OpenTabletDriver"
		  ".local/share/PrismLauncher"
	  ];
	};
}
