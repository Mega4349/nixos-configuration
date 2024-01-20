{ pkgs, inputs, ... }:

{
	nixpkgs.overlays = [
		#https://github.com/NixOS/nixpkgs/issues/239424
    (final: prev: {
      avidemux = prev.avidemux.overrideAttrs (oldAttrs: {
        buildCommand = oldAttrs.buildCommand + ''
          mv $out/bin/avidemux $out/bin/avidemux3
          echo 'LD_LIBRARY_PATH=$(dirname $(readlink -f $(which avidemux3)))/../lib/ avidemux3 "$@"' >> $out/bin/avidemux
          chmod +x $out/bin/avidemux

          mv $out/bin/avidemux3_cli $out/bin/avidemux3_cli_old
          echo 'LD_LIBRARY_PATH=$(dirname $(readlink -f $(which avidemux3_cli)))/../lib/ avidemux3_cli_old "$@"' >> $out/bin/avidemux3_cli
          chmod +x $out/bin/avidemux3_cli
        '';
      });
    })
  ];

	home = {
		packages = with pkgs; [
			krita
			
      libreoffice
			
      blender-hip
			
      deluge-gtk

			trackma-gtk
									
      zathura
			imv
			gimp
      avidemux
			
      wootility
			via
      
      mission-center
		  gpu-viewer
      
      qalculate-gtk

      unrar
  		unzip
	  	xarchiver
		];

  	persistence."/nix/persist/home/mega" = {
			directories = [
				".config/blender"
				".config/deluge"
				".config/wootility-lekker"
				".config/trackma"

				".local/share/trackma"
			];
			files = [ # fricking kde apps and not having config directories
				".config/kriarc"
				".config/kritadisplayrc"
			];
  	};
	};
}
