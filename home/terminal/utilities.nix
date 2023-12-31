{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unrar 
    unzip

	  neofetch
    fastfetch
		pfetch

    ani-cli
		manga-cli
    
    htop
    btop
    amdgpu_top

    (nvtop.override {
      nvidia = false;
      msm = false;
    })
  ];
  
  xdg.configFile = {
		"btop".source = ./config/btop;
		"neofetch".source = ./config/neofetch;
	};
}
