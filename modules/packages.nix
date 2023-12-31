{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-gaming.nixosModules.steamCompat
  ];

  programs = {
    # needs setuid binary which is provided by the nixos module
    wshowkeys.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = [
        inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      ];
    };
    # Gamemode to run games better
    gamemode.enable = true;
		nano.enable = false;
  };

  environment.systemPackages = with pkgs; [
    git
  	vim
  	wget
    curl
			
  	pciutils
		glxinfo
		vulkan-tools
    psmisc
  	jq
		tree
    libva-utils

  	wineWowPackages.staging
    mono

		cachix
  ];
}
