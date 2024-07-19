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

    # Fix for command-not-found with flakes
    programsdb = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Nix User Repository, used for firefox extensions
    nur.url = "github:nix-community/NUR";

    # Game stuff
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Anyrun launcher
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # View nixos options in anyrun :)
		anyrun-nixos-options = {
			url = "github:n3oney/anyrun-nixos-options";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, impermanence, programsdb, nur, nix-gaming, anyrun, anyrun-nixos-options, spicetify-nix, ... }: 
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
