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
			".config/VencordDesktop"
		];
	};
	
	xdg.configFile = {
		"Vencord/settings".source = ./config/Vencord/settings;
		"VencordDesktop/VencordDesktop/settings".source = ./config/Vencord/settings;
	};
}
