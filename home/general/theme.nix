{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-BL";
      package = pkgs.tokyo-night-gtk;
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
} 
