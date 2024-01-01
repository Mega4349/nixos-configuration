{ lib, osConfig, pkgs, inputs, ... }:

let
  games = inputs.nix-gaming.packages.${"x86_64-linux"};
in
lib.mkIf (osConfig.networking.hostName == "nixos-desktop") {
  home = {
    packages = with pkgs; [
      games.osu-stable
      games.wine-osu
      games.wine-discord-ipc-bridge

      winetricks
  	  mono

      (callPackage ./pkgs/danser {})
    ];
    
    persistence."/nix/persist/home/mega".directories = [
		  ".config/danser"
		  ".local/share/danser"
	  ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      xwayland = prev.xwayland.overrideAttrs (o: {
        patches = (o.patches or []) ++ [
          ./pkgs/patch/xwayland-vsync.diff
        ];
      });
    })
  ];
}
