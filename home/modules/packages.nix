{ pkgs, inputs, ... }:

{
	home.packages = with pkgs; [
		btop
		htop
		neofetch
	];
	
	xdg.configFile = {
		"btop".source = ./config/btop;

		"neofetch".source = ./config/neofetch;
	};
}
