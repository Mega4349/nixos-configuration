{ pkgs, inputs, ... }:

{
  home = {
		packages = [
    	(pkgs.discord-canary.override {
      	withVencord = true;
  		})
			pkgs.vesktop
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
