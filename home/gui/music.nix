{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      tidal-hifi
    ];
    persistence."/nix/persist/home/mega".directories = [
      ".config/tidal-hifi"
    ];
  };
}
