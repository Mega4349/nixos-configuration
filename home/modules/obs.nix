{ pkgs, inputs, ... }:

{
	imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];
	
	programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-vaapi
    ];
  };
	
  home.persistence."/nix/persist/home/mega" = {
		allowOther = true;
		directories = [
			".config/obs-studio"
		];
	};

	xdg.configFile."obs/studio/themes".source = ./config/obs-studio/themes;
}
