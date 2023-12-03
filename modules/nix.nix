{ inputs, ... }:

{
  #imports = [ inputs.aagl.nixosModules.default ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "mega" "@wheel" ]; # Trusted users can use binary cache
      auto-optimise-store = true; # Optimizing the store 
      connect-timeout = 40000; # Increased timeout because my internet is bad sometimes
			substituters = ["https://nix-gaming.cachix.org"];
  	  trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
    # Automatic garbage collection
    gc = { 
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;
}
