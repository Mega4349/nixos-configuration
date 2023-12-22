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
}
