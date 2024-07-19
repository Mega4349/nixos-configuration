{ pkgs, inputs, ... }:

let 
	spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
	imports = [ 
    inputs.spicetify-nix.homeManagerModules.default 
  ];

	programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.text;
    colorScheme = "TokyoNight";

    enabledExtensions = with spicePkgs.extensions; [
		  adblock
      fullAppDisplay
			#playlistIcons
    ];
  };

  home.persistence."/nix/persist/home/mega".directories = [
    ".config/spotify"
  ];
}
