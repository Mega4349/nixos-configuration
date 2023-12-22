{ pkgs, ... }:

{
  home.packages = [
    (pkgs.discord-canary.override {
      withVencord = true;
   })
	 pkgs.vesktop
  ];
	xdg.configFile = {
		"Vencord/settings".source = ./config/Vencord/settings;
		"VencordDesktop/VencordDesktop/settings".source = ./config/Vencord/settings;
	};
}
