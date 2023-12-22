{ pkgs, ... }:

{
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

}
