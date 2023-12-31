{ pkgs, system, lib, ... }:

{
	#Only meant for ALSA configurations, set to false for pipewire
	sound.enable = false;

	services = {
    openssh.enable = true;
    hardware.bolt.enable = true;
    # Service for deluge torrent client 
    deluge = {
      enable = true;
      user = "mega";
    };

		pipewire = {
		  enable = true;
		  alsa = {
		    enable = true;
		    support32Bit = true;
			};
		  pulse.enable = true;
		  wireplumber.enable = true;
		};
		
	  xserver = {
			# Remap menu key to super
			displayManager.sessionCommands = "sleep 5 && ${pkgs.xorg.xmodmap}/bin/xmodmap -e 'keycode 135 = Super_R' &";
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
	  
	  gvfs.enable = true; # For mounting and trash in thunar
	  tumbler.enable = true; # Thumbnail support for images
	  dbus.enable = true; # home-manager doesn't work on boot without dbus
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
	  # Enable firewall
	  firewall.enable = true;
	};
	
	security = {
	  polkit.enable = true;
    # for pipewire
	  rtkit.enable = true;
	};
	
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
