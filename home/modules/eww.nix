{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gtk3
    upower
    brightnessctl
    playerctl
    bluez
    gnome.gnome-bluetooth
    wlsunset
    socat
    jq
    acpi
    inotify-tools
    gjs
    wl-clipboard
    hyprpicker
    blueberry
    glib
  ];
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./config/eww;
  };
}
