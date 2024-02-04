{ pkgs, ... }:

let

  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
  
  randomSwww = pkgs.writeTextFile {
   name = "randomSwww";
   destination = "/bin/randomSwww";
   executable = true;

   text = '' 
     # This script will randomly go through the files of a directory, setting it
     # up as the wallpaper at regular intervals
     #
     # NOTE: this script is in bash (not posix shell), because the RANDOM variable
     # we use is not defined in posix
     
     if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
         echo "Usage:
         $0 <dir containing images>"
         exit 1
     fi
     
     # Edit below to control the images transition
     export SWWW_TRANSITION_FPS=60
     export SWWW_TRANSITION_STEP=2
     
     # This controls (in seconds) when to switch to the next image
     INTERVAL=300
     
     while true; do
         find "$1" \
             | while read -r img; do
                 echo "$((RANDOM % 1000)):$img"
             done \
             | sort -n | cut -d':' -f2- \
             | while read -r img; do
                 swww img --transition-type wipe --transition-angle 30 "$img"
                 sleep $INTERVAL
             done
     done
    '';
  };
  
	roundedShadowScript = pkgs.writeTextFile {
    name = "roundedShadowScipt";
    destination = "/bin/roundedShadowScript";
    executable = true;

    text = ''
      convert grimshot.png \
      \( +clone  -alpha extract \
        -draw 'fill black polygon 0,0 0,10 10,0 fill white circle 10,10 10,0' \
        \( +clone -flip \) -compose Multiply -composite \
        \( +clone -flop \) -compose Multiply -composite \
      \) -alpha off -compose CopyOpacity -composite  rounded.png

      convert -page +15+15 rounded.png -alpha set \
          \( +clone -background black -shadow 80x6+0+0 \) +swap \
          -background none -mosaic screenshot.png
    '';
  };

	shadowScript = pkgs.writeTextFile {
    name = "shadowScript";
    destination = "/bin/shadowScript";
    executable = true;

    text = ''
      convert -page +30+30 grimshot.png -alpha set \
          \( +clone -background black -shadow 80x20+0+0 \) +swap \
          -background none -mosaic screenshot.png
    '';
  };

	cleanUpScript = pkgs.writeTextFile {
    name = "cleanUpScript";
    destination = "/bin/cleanUpScript";
    executable = true;

    text = '' 
      rm grimshot.png rounded.png
    '';
  };

	copyImageScript = pkgs.writeTextFile {
    name = "copyImageScript";
    destination = "/bin/copyImageScript";
    executable = true;

    text = ''
      wl-copy -t image/png < screenshot.png
    '';
  };
in
{
	home.packages = with pkgs; [
		imagemagick
    swww
    
    dbus-sway-environment
    randomSwww
		roundedShadowScript
		shadowScript
		cleanUpScript
		copyImageScript
	];
}
