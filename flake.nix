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

    # Sops-nix for secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository(used for firefox extensions)
    nur.url = "github:nix-community/NUR";

    # Stylix for theming
    stylix.url = "github:danth/stylix";

    # Game stuff and pipewire low latency module
    nix-gaming.url = "github:fufexan/nix-gaming";

    flatpak.url = "github:GermanBread/declarative-flatpak/stable";

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

    #anyrun-nixos-options = {
      #url = "github:n3oney/anyrun-nixos-options";
    #};

    #hyprland.url = "github:hyprwm/Hyprland";
  
    nx = {
      url = "sourcehut:~sntx/nx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
  };

  # Nix configurations, including binary cahces so you don't need to build things 
  nixConfig = {
    allowUnfree = true;
    buildersUseSubstituters = true;
    experimental-features = [ "flakes" "nix-command" ];
    substituters = [ "https://cache.nixos.org/" ];
    extra-substituters = [
      "https://nix-community.cachix.org/"
      "https://nix-gaming.cachix.org/"
      "https://anyrun.cachix.org/"
      "https://ezkea.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };

  outputs = inputs@{ self, nixpkgs, home-manager, impermanence, sops-nix, nur, stylix, nix-gaming, flatpak, aagl, anyrun, nx, ... }: 
  let
    mkSystem = modules: nixpkgs.lib.nixosSystem {
      inherit modules;
      system = "x86_64-linux";
      #config.allowUnfree = true;
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
