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
    swayidle
		swaynotificationcenter
	];
    
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.gtklock}/bin/gtklock"; }
      #{ event = "lock"; command = "lock"; }
      #{ event = "after-resume"; command = "${pkgs.gtklock}/bin/gklock"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.gtklock}/bin/gtklock"; }
      { timeout = 600; command = "${pkgs.wlopm}/bin/wlopm --off \*"; resumeCommand = "${pkgs.wlopm}/bin/wlopm --on \*"; } #TODO fix \* not working for outputs
    ];
  };

	xdg.configFile = {
		"wlogout".source = ../config/wlogout;
		"gtklock".source = ../config/gtklock;
		"swaync".source = ../config/swaync;
	};
}
