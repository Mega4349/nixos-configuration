{ pkgs, inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  # Set time zone
  time.timeZone = "Europe/Stockholm";
  
  i18n.defaultLocale = "en_US.UTF-8";

  programs = { 
		zsh.enable = true;
		fish.enable = true;
	};

  # Define a user account. Don't forget to set a password
  users = {
    mutableUsers = false;
      defaultUserShell = pkgs.fish;
		users = {
      root = {
        initialPassword = "1234"; # TODO use secrets instead
      };
      mega = {
        isNormalUser = true;
        description = "mega";
        extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "plugdev" ]; # Enable ‘sudo’ for the user. ## replaced with doas 
        initialPassword = "1234";
      };
    };
  };

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        users = [ "mega" ];
          keepEnv = true;
          persist = true;
      }]; 
    };
  };

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.mega = import ../home;
  };

  system.stateVersion = "23.05";
}
