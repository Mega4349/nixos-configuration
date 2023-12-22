{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-gaming.nixosModules.steamCompat
  ];

  programs = {
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

		steamtinkerlaunch

    jmtpfs

    amdgpu_top
		
		cachix

    appimage-run

    #fastfetch
    #pfetch
  ];
  
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
