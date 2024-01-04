{ pkgs, inputs, ... }:

let
  lazer-vulkan = pkgs.writeTextFile {
    name = "lazer-vulkan";
    destination = "/bin/lazer-vulkan";
    executable = true;

    text = ''
      #!/usr/bin/env bash
      sed -i 's/Renderer = .*/Renderer = Vulkan/' $HOME/.local/share/osu/framework.ini
      osu-lazer
    '';
  };

  games = inputs.nix-gaming.packages.${"x86_64-linux"};
in
{
  home = {
    packages = with pkgs; [
      gnused

      prismlauncher
  	  heroic
      bottles
      stepmania
      steamtinkerlaunch

      lazer-vulkan
  	  games.osu-lazer-bin
    ];

	  persistence."/nix/persist/home/mega".directories = [
		  ".local/share/Steam"
		  ".local/share/osu"
      ".local/share/bottles"
		  ".config/heroic"
		  ".config/OpenTabletDriver"
		  ".local/share/honkers-railway-launcher"
		  ".local/share/PrismLauncher"
		  ".stepmania-5.1"
	  ];
	};
}
