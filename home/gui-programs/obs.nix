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
	  ];
    sessionVariables = {
      OBS_VKCAPTURE=1; 
    };
  };

	xdg.configFile."obs-studio/themes".source = ./config/obs-studio/themes;
}
