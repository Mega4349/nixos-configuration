{ pkgs, inputs, ... }:

let 
	spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
	imports = [ 
    inputs.spicetify-nix.homeManagerModule 
  ];

	programs.spicetify = {
    enable = true;
    
    # too lazy to make tokyonight work, catppuccin mocha is close enough
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    spotifyPackage = (pkgs.callPackage ../../pkgs/spotify-adblock {} );

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
			playlistIcons
			lastfm
      shuffle
    ];
  };
}
