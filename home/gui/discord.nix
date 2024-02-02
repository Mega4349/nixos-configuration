{ pkgs, ... }:

{
  home = {
		packages = with pkgs; [
    	(discord-canary.override {
      	withVencord = true;
  		})
			vesktop
  	];
		persistence."/nix/persist/home/mega".directories = [
			".config/discordcanary"
			".config/vesktop"
		];
	};
	
	xdg.configFile = {
		"Vencord/settings".source = ./config/Vencord/settings;
		"vesktop/settings".source = ./config/Vencord/settings;
	};
}
