{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
  
  home = {
		packages = with pkgs; [ 
			gtk-engine-murrine 
			gtk_engines 
		];
		pointerCursor = {
    	name = "Bibata-Original-Ice";
    	package = pkgs.bibata-cursors;
    	size = 24;
    	gtk.enable = true;
    	x11 = {
      	enable = true;
      	defaultCursor = "Bibata-Original-Ice";
    	};
  	};
	};

	qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.package = pkgs.tokyo-night-gtk;
  };

  xdg.configFile."gtk-3.0/gtk.css".text = ''
    window {
      border-radius: 0 0 0 0;
    }
  '';
} 
