{ pkgs, inputs, ... }:

{
	programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-vaapi
    ];
  };
	
  home = {
    persistence."/nix/persist/home/mega".directories = [
		  ".config/obs-studio"
      ".config/kooha"
	  ];
    sessionVariables = {
      OBS_VKCAPTURE=1; 
    };
    packages = with pkgs; [
      ffmpeg
      kooha
      gst_all_1.gst-vaapi
    ];
  };

	xdg = {
    configFile."obs-studio/themes".source = ./config/obs-studio/themes;
    
    desktopEntries."io.github.seadve.Kooha.desktop" = {
      name = "Kooha";
      exec = "env KOOHA_EXPERIMENTAL=1 GST_VAAPI_ALL_DRIVERS=1 kooha";   
      comment = "Elegantly record your screen";
      type = "Application";
      terminal = false;
      categories = [ "GTK" "GNOME" "Utility" "Recorder" ];
      icon = "io.github.seadve.Kooha";
      startupNotify = true;
      settings = {
        Keywords = "Screencast;Recorder;Screen;Video";
      };
    };
  };

  dconf.settings = {
    "io/github/seadve/Kooha" = {
      capture-mode = "monitor-window";
      profile-id = "mp4";
      record-delay = 3;
      record-speaker = true;
      show-pointer = true;
      video-framerate = 60;
    };
  };
}
