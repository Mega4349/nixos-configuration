{ pkgs, ... }:

{
  home.packages = with pkgs; [
    river
    swww
    way-displays
  ];

  xdg.configFile = {
    "xdg-desktop-portal/river-portals.conf".text = ''
      [preferred]
      default=gtk
      org.freedesktop.impl.portal.ScreenCast=wlr
      org.freedesktop.impl.portal.Screenshot=wlr
    '';
  };
}
