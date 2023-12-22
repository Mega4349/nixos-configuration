{ pkgs, ... }:

{
  home.packages = with pkgs; [
    imv
    transmission-gtk
    deluge
    gimp
    avidemux
    musikcube
    yt-dlp
    ani-cli
    manga-cli
  ];
}
