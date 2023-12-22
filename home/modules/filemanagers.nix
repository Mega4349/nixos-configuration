{ pkgs, ... }:

let 
  wezterm_cwd = pkgs.writeTextFile {
    name = "wezterm_cwd";
    destination = "/bin/wezterm_cwd";
    executable = true;

    text = ''
      #!/bin/sh

      wezterm start --cwd "$PWD"
    '';
  };
  
in

{
	nixpkgs.overlays = [
		(final: prev: {
  	  ranger-sixel = prev.ranger.overrideAttrs (oldAttrs: {
      	patches = (oldAttrs.patches or [ ]) ++ [
      		(prev.fetchpatch {
          	url = "https://github.com/3ap/ranger/commit/ef9ec1f0e0786e2935c233e4321684514c2c6553.patch";
        		sha256 = "sha256-MJbIBuFeOvYnF6KntWJ2ODQ4KAcbnFEQ1axt1iQGkWY=";
        	})
    		];
  		});
  	})
	];

  home.packages = with pkgs; [
    ranger-sixel
    ffmpegthumbnailer
    evince
    xfce.tumbler
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    cinnamon.nemo
		mpv
    wezterm_cwd
  ];

	dconf.settings = {
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "wezterm_cwd";
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
    "ranger".source = ./config/ranger;

    "swaync".source = ./config/swaync;

    # btop
    "btop/btop.conf".source = ./config/btop/btop.conf;

    # obs themes
    "obs-studio/themes".source = ./config/obs-studio/themes;
  };
}
