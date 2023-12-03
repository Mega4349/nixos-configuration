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
    unzip
    pciutils
    psmisc
    btop
    htop
    jq
    libva-utils

    wineWowPackages.staging
    mono

		steamtinkerlaunch

    jmtpfs

    amdgpu_top

    appimage-run

    #fastfetch
    #pfetch
  ];
  
  # Overlay to remove vsync from xwayland
  #nixpkgs.overlays = [
  #  (final: prev: {
  #    xwayland = prev.xwayland.overrideAttrs (o: {
  #      patches = (o.patches or [ ]) ++ [
  #        ./files/xwayland-vsync.diff
  #      ];
  #    });
  #  })
  #]; 

  # remove and build discover overlay and missioncenter from source instead
  #services.flatpak.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
