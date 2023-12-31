{ lib, osConfig, pkgs, inputs, ... }:

lib.mkIf (osConfig.networking.hostName == "nixos-desktop") {
  home.packages = let
    games = inputs.nix-gaming.packages.${"x86_64-linux"};
  in [
    games.osu-stable
    games.wine-osu
    games.wine-discord-ipc-bridge
    pkgs.winetricks
  	pkgs.mono
  ];

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
