{ lib, osConfig, pkgs, inputs, config, ... }:

lib.mkIf (osConfig.networking.hostName == "nixos-desktop") {
  home.packages = let 
    games = inputs.nix-gaming.packages.${"x86_64-linux"};
  in [
    pkgs.prismlauncher
     
    pkgs.stepmania

    games.osu-lazer-bin

    #games.proton-ge

    games.wine-discord-ipc-bridge

    #pkgs.wineWowPackages.staging # Conflicts with osu-wine from nix-gaming
    pkgs.winetricks
    pkgs.mono
    games.wine-osu

    games.osu-stable
  ];

  xdg.configFile."pipewire".source = ./config/pipewire;
}
