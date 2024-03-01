{ pkgs, config, ... }:

{
	home = {
    packages = with pkgs; [
		  wlogout
      wlopm
		  swappy
      swaybg
		  copyq
		  pavucontrol
		  xdg-utils
		  swayidle
		  wl-gammactl
		  wl-clipboard
		  pamixer
		  swaynotificationcenter
	  ];
    # Persist screen brightness between boots TODO doesn't work
    persistence."/nix/persist/home/mega".directories = [
      ".config/light"
    ];
  };
    
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshot = true;
      color = "000000ff";
      text-color = "9aa5ceff";
      indicator-x-position = 180;
      indicator-y-position = 900;
      indicator-radius = 100;
      indicator-thickness = 10;
      timestr = "%H:%M";
      datestr = "%a %d %b";
      inside-color = "00000000";
      ring-color = "ffffffff";
      separator-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "f7768eff";
      ring-ver-color = "7aa2f7ff";
      ring-wrong-color = "f7768eff";
      line-uses-inside = true;
      key-hl-color = "f7768eff";
      bs-hl-color = "f7768eff";

      effect-blur = "8x8";

      clock = true;
      indicator = true;

      fade-in = 0.5;
      grace = 2;
    };
  };
  
  services = {
    copyq.enable = true;
    swayidle = {
      enable = true;
      events = [
        { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
      ];
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock-effects}/bin/swaylock -f";
        }
        {
          timeout = 420;
          command = "${pkgs.systemd}/bin/systemctl -i suspend";
        }
      ];
    };
  };

	xdg.configFile = {
		"wlogout".source = ./config/wlogout;
		"swaync".source = ./config/swaync;
	};
}
