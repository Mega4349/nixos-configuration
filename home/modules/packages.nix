{ pkgs, inputs, ... }:

{
	home.packages = with pkgs; [
		btop
		htop
		neofetch
		fastfetch
		pfetch
		gpu-viewer
		amdgpu_top
		jmtpfs
	];
	
	xdg.configFile = {
		"btop".source = ./config/btop;
		"neofetch".source = ./config/neofetch;
	};
}
