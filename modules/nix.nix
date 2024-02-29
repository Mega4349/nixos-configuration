{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "mega" "@wheel" ]; # Trusted users can use binary cache
    auto-optimise-store = true; # Optimizing /nix/store 
    connect-timeout = 40000; # Increased timeout because my internet is bad sometimes
  	substituters = [
    	"https://nix-community.cachix.org/"
    	"https://nix-gaming.cachix.org/"
    	"https://anyrun.cachix.org/"
    	"https://ezkea.cachix.org"
  	];
  	trusted-public-keys = [
    	"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    	"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    	"anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    	"ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
  	];
  };

  nixpkgs.config = {
		allowUnfree = true;
		allowBroken = true;
	};
  
  environment.systemPackages = with pkgs; [
    cachix
  ];
}
