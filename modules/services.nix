{ pkgs, inputs, system, lib, ... }:

{
	#Only meant for ALSA configurations, set to false for pipewire
	sound.enable = false;

	services = {
		pipewire = {
		  enable = true;
		  alsa = {
		    enable = true;
		    support32Bit = true;
		};
		  pulse.enable = true;
		  #jack.enable = true;
		  wireplumber.enable = true;
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
	  
	  flatpak.enable = true;
	  gvfs.enable = true; # For mounting and trash in thunar
	  tumbler.enable = true; # Thumbnail support for images
	  dbus.enable = true;
	};

	systemd = {
	  user.services.polkit-gnome-authentication-agent-1 = {
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
	};

	networking = {
	  # Enable NetworkManager for networking
	  networkmanager.enable = true;
	  # Enable firewall
	  firewall = {
	  enable = true;
	    allowedTCPPortRanges = [ 
	      { from = 1714; to = 1764; } # KDE Connect
	    ];  
	    allowedUDPPortRanges = [ 
	      { from = 1714; to = 1764; } # KDE Connect
	    ];
	  };  
	};
	
	security = {
	  polkit.enable = true;
	  rtkit.enable = true;
	};
	
	environment.systemPackages = with pkgs; [ 
		polkit_gnome 
		slurp
		swaynotificationcenter
	]; 
	
	xdg.portal = {
	  enable = true;
	  wlr = {
    	enable = true;
    	settings = {
      	screencast = {
      		max_fps = 60;
					exec_before = "${pkgs.swaynotificationcenter}/bin/swaync-client --inhibitor-add \"xdg-desktop-portal-wlr\"";
					exec_after = "${pkgs.swaynotificationcenter}/bin/swaync-client --inhibitor-remove \"xdg-desktop-portal-wlr\"";
        	chooser_type = "simple";
        	chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or -B 00000066 -b 00000099";
      	};
    	};
  	};
	  extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
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
