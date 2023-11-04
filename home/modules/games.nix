{ pkgs, inputs, config, ... }:

{
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

    games.osu-stable#.override rec {
      #wine = config.packages.wine-osu;
      #wine-discord-ipc-bridge = games.wine-discord-ipc-bridge.override {inherit wine;};
    #}
  ];
  
  #home.packages = let
  #  gamePkgs = inputs.nix-gaming.packages.${pkgs.system};
  #in [
  #  gamePkgs.wine-osu
  #  gamePkgs.osu-stable.override rec {
  #    wine = wine-osu;
  #    wine-discord-ipc-bridge = gamePkgs.wine-discord-ipc-bridge.override {inherit wine;}; # or override this one as well
  #  }
  #];
}
