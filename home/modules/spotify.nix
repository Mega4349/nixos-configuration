{ pkgs, inputs, ... }:

let 
	tokyonightTheme = "https://github.com/spicetify/spicetify-themes";
	spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
	imports = [ inputs.spicetify-nix.homeManagerModule ];

	programs.spicetify = {
    enable = true;
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
