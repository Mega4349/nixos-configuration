{ pkgs, ... }:

{
	home.packages = with pkgs; [
		wlogout
		gtklock
		swww
		swappy
		copyq
		pavucontrol
		wlopm
		xdg-utils
		swayidle
		wl-gammactl
		wl-clipboard
		pamixer
		swaynotificationcenter
	];

	xdg.configFile = {
		"wlogout".source = ../config/wlogout;
		"gtklock".source = ../config/gtklock;
		"swaync".source = ../config/swaync;
	};
}
