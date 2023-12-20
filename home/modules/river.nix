{ pkgs, ... }:

{
  home.packages = with pkgs; [
    river
    swww
    way-displays
  ];
}
