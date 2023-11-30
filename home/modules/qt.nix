{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.package = pkgs.tokyo-night-gtk;
  };
}
