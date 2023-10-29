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
  
  home.pointerCursor = {
    name = "Bibata-Original-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "Bibata-Original-Ice";
    };
  };
} 
