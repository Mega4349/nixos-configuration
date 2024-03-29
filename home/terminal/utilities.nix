{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    unrar 
    unzip

    jmtpfs

    #realesrgan-ncnn-vulkan
    
	  neofetch
    fastfetch
		pfetch

    (pkgs.ani-cli.override { mpv = config.programs.mpv.finalPackage; })
        
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
