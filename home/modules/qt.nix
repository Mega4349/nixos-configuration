{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.package = pkgs.flat-remix-gtk;
  };
}
