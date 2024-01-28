{ pkgs, system, lib, ... }:

{
	services = {
    openssh.enable = true;
    
    # Service for deluge torrent client 
    deluge = {
      enable = true;
      user = "mega";
      group = "users";
      #dataDir = "/home/mega/.config/deluge";
    };
		
	  xserver = {
	    desktopManager.xterm.enable = false;
	    extraLayouts.canary = {
	      description = "Canary keyboard layout";
	    	languages = ["eng"];
	      symbolsFile = builtins.fetchurl {
	        url = "https://raw.githubusercontent.com/Apsu/Canary/main/canary";
	        sha256 = "sha256:1rv9hb9v1rwn2abds09kc5nrgypzzg6g0izynil8v8m16a99dznj";
	      };
	    };
	  };
	};

	systemd = {
	  user.services = {
      polkit-gnome-authentication-agent-1 = {
	      description = "polkit-gnome-authentication-agent-1";
	      wantedBy = [ "graphical-session.target" ];
	      wants = [ "graphical-session.target" ];
	      after = [ "graphical-session.target" ];
	      serviceConfig = {
	        Type = "simple";
	        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	        Restart = "on-failure";
	        RestartSec = 1;
	        TimeoutStopSec = 10;
	      };
	    };
      mpdscribble = {
        description = "last.fm scrobbler for MPD";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.mpdscribble}/bin/mpdscribble";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 300;
        };
      };
    };
	};

	networking = {
	  # Enable NetworkManager for networking
	  networkmanager.enable = true;
    # Disable wpa_supplicant
    wireless.enable = false;
	  # Enable firewall
	  firewall.enable = true;
	};
	
	security.polkit.enable = true;
	
	environment.systemPackages = with pkgs; [ 
		polkit_gnome 
		slurp
		swaynotificationcenter
    mpdscribble
		xorg.xmodmap
	]; 
	
	xdg.portal = {
	  enable = true;
	  wlr = {
    	enable = true;
    	settings = {
      	screencast = {
      		max_fps = 60;
					# notification inhibition in swaync when screensharing
					exec_before = "${pkgs.swaynotificationcenter}/bin/swaync-client --inhibitor-add \"xdg-desktop-portal-wlr\"";
					exec_after = "${pkgs.swaynotificationcenter}/bin/swaync-client --inhibitor-remove \"xdg-desktop-portal-wlr\"";
        	chooser_type = "simple";
        	chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or -B 00000066 -b 00000099";
      	};
    	};
  	};
		# remove xdg-desktop-portal-gtk as it collides with portal from gnome
	  extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
	  config = {
	    common.default = [ "gtk" ];
	    sway = { 
				default = [ "gtk" ];
				"org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
				"org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
			};
	  };
	};
}
