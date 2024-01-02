{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-gaming.nixosModules.steamCompat
    inputs.home-manager.nixosModules.home-manager 
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.mega = import ../home;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  
  programs = {
    dconf.enable = true; # needed to make home-manager happy
    fuse.userAllowOther = true;
    # program to show keypresses in wayland, needs setuid binary which is provided by the nixos module
    wshowkeys.enable = true;
    # Steam doesn't have a hm module, I chose to enable it system-wide
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = [
        inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      ];
    };
    # Gamemode to run games better
    gamemode.enable = true;
  };
  
  services = {
    gvfs.enable = true; # For mounting without root and trash 
	  tumbler.enable = true; # Thumbnail support for images
	  dbus.enable = true;
  };

  # Important, swaylock will not unluck without this
  security.pam.services.swaylock = {};
}
