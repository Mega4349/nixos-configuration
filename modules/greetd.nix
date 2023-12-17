{ pkgs, lib, ... }:

let 
	swayConfig = pkgs.writeText "sway-config" ''
		exec "regreet; swaymsg exit"
		bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
	'';
in
{
	services.greetd = {
		enable = true;
		#settings = {
		#	default_session = {
		#		command = "dbus-run-session ${pkgs.swayfx}/bin/sway --config ${swayConfig}";
		#	};
		#};
	};

	programs.regreet = {
		enable = true;
		settings = { 
			background = {
				path = ./files/trees.jpg; 
				fit = "Fill";
			};
			gtk = {
				cursor_theme_name = "Bibata-Original-Ice";
				theme_name = "Tokyonight-Dark-B";
			};
			default_session = {
				command = "dbus-run-session ${pkgs.swayfx}/bin/sway --config ${swayConfig}";
			};
		};
		extraCss = ''
		'';
	};

	security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";

	environment.systemPackages = with pkgs; [
		tokyo-night-gtk
		bibata-cursors
	];
}
