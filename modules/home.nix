{ pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager 
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.mega = import ../home;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    #gnome.excludePackages = (with pkgs; [
    #  gnome-photos
    #  gnome-tour
    #  gedit # text editor
    #]) ++ (with pkgs.gnome; [
    #  cheese # webcam tool
    #  gnome-music
    #  gnome-terminal
    #  epiphany # web browser
    #  geary # email reader
    #  evince # document viewer
    #  gnome-characters
    #  totem # video player
    #  tali # poker game
    #  iagno # go game
    #  hitori # sudoku game
    #  atomix # puzzle game
    #]);
  };
  
  programs = {
    sway = {
      enable = true;
      extraPackages = lib.mkForce [ ];
    };
    dconf.enable = true; # needed to make home-manager happy
    fuse.userAllowOther = true;
    # program to show keypresses in wayland, needs setuid binary which is provided by the nixos module
    wshowkeys.enable = true;
    # Steam doesn't have a hm module, I chose to enable it system-wide
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    # Gamemode to run games better
    gamemode.enable = true;
  };
  
  services = {
    #xserver.desktopManager.gnome.enable = true;
    gvfs.enable = true; # For mounting without root and trash 
	  tumbler.enable = true; # Thumbnail support for images
	  dbus.enable = true;
  };

  # Important, swaylock will not unluck without this
  security.pam.services.swaylock = {};
}
