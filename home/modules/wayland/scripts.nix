{ pkgs, ... }:

let
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

		roundedShadowScript
		shadowScript
		cleanUpScript
		copyImageScript
	];
}
