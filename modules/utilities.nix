{ pkgs, inputs, ... }:

{
  programs.nano.enable = false;

  environment.systemPackages = with pkgs; [
    git
  	vim
  	wget
    curl
		
  	pciutils
		glxinfo
		vulkan-tools
    psmisc
    usbutils
  	jq
		tree
    libva-utils
  ];
}
