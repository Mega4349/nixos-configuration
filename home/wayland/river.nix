{ pkgs, ... }:

{
  home.packages = with pkgs; [
    river
  ];

	xdg.configFile."river".source = ./config/river;
}
