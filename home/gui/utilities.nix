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
		lib.mkIf (osConfig.networking.hostName == "nixos-desktop") packages = with pkgs; [
			blender-hip
			orca-slicer
			wootility
			via
			avidemux
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
