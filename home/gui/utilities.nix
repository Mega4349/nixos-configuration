{ pkgs, inputs, ... }:

{
	home = {
		packages = with pkgs; [
			krita
			
      libreoffice
			
      #blender-hip
			 
      deluge-gtk

      zathura
			imv
			gimp
      avidemux
			
      wootility
			via
      
      mission-center
		  gpu-viewer
      
      qalculate-gtk
			
			gparted
      
			unrar
  		unzip
	  	xarchiver
		];

  	persistence."/nix/persist/home/mega" = {
			directories = [
				".config/blender"
				".config/deluge"
				".config/wootility-lekker"
			];
			files = [ # fricking kde apps and not having config directories
				".config/kriarc"
				".config/kritadisplayrc"
			];
  	};
	};
}
