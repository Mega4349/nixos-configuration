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

    theme = spicePkgs.themes.text;
    colorScheme = "TokyoNight";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
			playlistIcons
    ];
  };

  home.persistence."/nix/persist/home/mega".directories = [
    ".config/spotify"
  ];
}
