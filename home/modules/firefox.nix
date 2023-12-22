{ pkgs, inputs, ... }:

{
	imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  home = {
		packages = with pkgs; [
			thunderbird
		];
		persistence."/nix/persist/home/mega" = {
			allowOther = true;
			directories = [
				".mozilla"
				".thunderbird"
			];
		};
	};
	
	nixpkgs.overlays = [ inputs.nur.overlay ];

  programs.firefox = {
    enable = true;
    profiles.mega = {
      id = 0;
      name = "mega";
      search = {
        force = true;
        default = "DuckDuckGo";
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        betterttv
        clearurls
        don-t-fuck-with-paste
        duckduckgo-privacy-essentials
        enhanced-github
        ff2mpv
        #firefox-translators
        github-file-icons
        greasemonkey 
        #i-dont-care-about-cookies
        image-search-options
        improved-tube
        istilldontcareaboutcookies
        keepassxc-browser
        link-cleaner
        return-youtube-dislikes
        search-by-image
        skip-redirect
        sponsorblock
        stylus
        tab-counter-plus
        theater-mode-for-youtube
        translate-web-pages
        unpaywall
        youtube-shorts-block
      	video-downloadhelper
      	darkreader
      	text-contrast-for-dark-themes
      ];
    };
  };
}
