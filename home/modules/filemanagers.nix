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
  home.packages = with pkgs; [
    ranger-sixel
    ffmpegthumbnailer
    #poppler
    evince
    xfce.tumbler
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    cinnamon.nemo
		mpv
    wezterm_cwd
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      pdf_reader = [ "zathura.desktop;" ];
      browser = [ "firefox.desktop;" ];
      video_player = [ "mpv.desktop;" ];
      image_viewer = [ "imv-dir.desktop;" ];
    in {
      "application/pdf" = pdf_reader;
      "audio/mp3" = video_player;
			"audio/ogg" = video_player;
			"video/mp4" = video_player;
			"video/mkv" = video_player;
			"image/jpeg" = image_viewer;
			"image/png" = image_viewer;
			"image/gif" = image_viewer;
    };

    #associations.removed = let browser = [ "chromium.desktop" ];
    #in { "application/pdf" = browser; };
  };

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
    "ranger/rc.conf".source = ./config/ranger/rc.conf;
    "ranger/scope.sh" = {
      source = ./config/ranger/scope.sh;
      executable = true;
    };
		"ranger/plugins".source = ./config/ranger/plugins;

    #TODO move to separate file
    "Vencord/settings/settings.json".source = ./config/Vencord/settings/settings.json;
    "Vencord/settings/quickCss.css".source = ./config/Vencord/settings/quickCss.css; 

    "swaync".source = ./config/swaync;

    #thunar configuration
    #"xfce4/xfconf/xfce-perchannel-xml/thunar.xml".source = ./config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml;

    # btop
    "btop/btop.conf".source = ./config/btop/btop.conf;

    # obs themes
    "obs-studio/themes".source = ./config/obs-studio/themes;
  };
}
