{ pkgs, inputs, ... }:

{
	imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  home = {
		packages = [
    	(pkgs.discord-canary.override {
      	withVencord = true;
  		})
			pkgs.vesktop
  	];
		persistence."/nix/persist/home/mega" = {
			allowOther = true;
			directories = [
				".config/discordcanary"
			];
		};
	};
	
	xdg.configFile = {
		"Vencord/settings".source = ./config/Vencord/settings;
		"VencordDesktop/VencordDesktop/settings".source = ./config/Vencord/settings;
	};
}
