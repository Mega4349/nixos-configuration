{ pkgs, inputs, ... }:

let 
	tokyonightTheme = "https://github.com/spicetify/spicetify-themes";
	spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
	imports = [ inputs.spicetify-nix.homeManagerModule ];

	programs.spicetify = {
    enable = true;
		colorScheme = "Night";

		theme = {
			name = "Tokyo";
			src = tokyonightTheme;
			requiredExtensions = [
				{
					filename = "user.css";
					src = "${tokyonightTheme}";
				}
			];
			injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
		};

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
			playlistIcons
			lastfm
      shuffle # shuffle+ (special characters are sanitized out of ext names)
     ];
  };
}
