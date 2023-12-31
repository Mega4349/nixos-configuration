{ pkgs, ... }:

{
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

        # $ mkpasswd
        #hashedPasswordFile = "/etc/hashedPasswordFile";
      };
    };
  };
  
  programs = { 
		zsh.enable = true;
		fish.enable = true;
	};

  #environment.persistence."/nix/persist".files = [
  #  "/etc/hashedPasswordFile"
  #];

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
}
