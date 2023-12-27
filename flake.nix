{
  description = "Mega's NixOS Flake";

  inputs = {
    # Use unstable branch of nixpkgs 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager to manage configurations and programs for users
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Impermanence for persistence on ephemeral root
    impermanence.url = "github:nix-community/impermanence";

    # Nix User Repository(used for firefox extensions)
    nur.url = "github:nix-community/NUR";

    # Game stuff and pipewire low latency module
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Game stuff
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Anyrun launcher
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
		anyrun-nixos-options = {
			url = "github:n3oney/anyrun-nixos-options";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		spicetify-nix ={ 
			url = "github:the-argus/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  # Nix configurations, including binary cahces so you don't need to build things 
  #nixConfig = {
  #  acceptFlakeConfig = true;
  #  allowUnfree = true;
  #  buildersUseSubstituters = true;
  #  experimental-features = [ "flakes" "nix-command" ];
  #  substituters = [ "https://cache.nixos.org/" ];
  #  extra-substituters = [
  #    "https://nix-community.cachix.org/"
  #    "https://nix-gaming.cachix.org/"
  #    "https://anyrun.cachix.org/"
  #    "https://ezkea.cachix.org"
  #  ];
  #  extra-trusted-public-keys = [
  #    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #    "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
  #    "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
  #    "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
  #  ];
  #};

  outputs = inputs@{ self, nixpkgs, home-manager, impermanence, nur, nix-gaming, aagl, anyrun, nixvim, spicetify-nix, ... }: 
  let
    mkSystem = modules: nixpkgs.lib.nixosSystem {
      inherit modules;
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
    };

    mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
      inherit modules pkgs;
      extraSpecialArgs = { inherit inputs nur; };
    };

  in {
    nixosConfigurations = {
      nixos-desktop = mkSystem [ ./hosts/nixos-desktop ];
      nixos-laptop = mkSystem [ ./hosts/nixos-laptop ];
    };

    homeConfiguration."mega" = mkHome [ ./home ] nixpkgs.legacypackages.system;
  };
}
