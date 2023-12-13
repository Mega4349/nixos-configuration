{ pkgs, ... }:

{
  gtk = {
    enable = true;
    #gtk3.extraConfig.gtk-decoration-layout = "menu:";
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
		packages = with pkgs; [ gtk-engine-murrine gtk_engines ];
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

  xdg.configFile."gtk-3.0/gtk.css".text = '' 
    /*.nemo-places-sidebar .view { */ 
    .nemo-window .sidebar .view {
    background-color: @theme_bg_color;
    color: @theme_fg_color;
    }
  '';
} 
