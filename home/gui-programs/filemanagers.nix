{ pkgs, ... }:

let 
  kitty_cwd = pkgs.writeTextFile {
    name = "kitty_cwd";
    destination = "/bin/kitty_cwd";
    executable = true;

    text = ''
      #!/bin/sh

      kitty --single-instance "$PWD"
    '';
  };
  
in

{
  home.packages = with pkgs; [
    ranger
    ffmpegthumbnailer
		ffmpeg
    xfce.tumbler
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    cinnamon.nemo
    kitty_cwd
		unrar
		unzip
		xarchiver
  ];

	dconf.settings = {
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "kitty_cwd";
    };
		"org/nemo/preferences" = {
			click-double-parent-folder = true;
			click-policy = "single";
			show-hidden-files = true;
			size-prefixes = "base-2";
			thumbnail-limit = "68719476735";
		};
  };

  xdg.configFile = {
    "ranger/plugins".source = ./config/ranger/plugins;
    "ranger/scope.sh".source = ./config/ranger/scope.sh;
    "ranger/rc.conf".source = ./config/ranger/rc.conf;
  };
}
