{ pkgs, ... }:

{
	home = {
		packages = with pkgs; [
		  krita
		  
	    libreoffice
		  
	    deluge-gtk
	
	    zathura
		  imv
		  gimp
		  
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
				".config/deluge"
			];
			files = [ # fricking kde apps and not having config directories
				".config/kriarc"
				".config/kritadisplayrc"
			];
  	};
	};
}
