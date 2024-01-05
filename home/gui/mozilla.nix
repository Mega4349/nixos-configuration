{ pkgs, inputs, ... }:

{
  home.persistence."/nix/persist/home/mega".directories = [
		".mozilla"
		".thunderbird"
	];
	
	nixpkgs.overlays = [ inputs.nur.overlay ];

  programs = {
    thunderbird = {
      enable = true;
      profiles.mega = {
        isDefault = true;
      };
    };

    firefox = {
      enable = true;
      profiles.mega = {
        id = 0;
        name = "mega";
        search = {
          force = true;
          default = "DuckDuckGo";
        };
        userChrome = ''
          /* Remove titlebar close button */
          .titlebar-buttonbox-container{ display:none }
          .titlebar-spacer[type="post-tabs"]{ display:none }

          /*** Remove items from image context menu ***/

          /* Email Image... */
          #context-sendimage, 
          
          /* Set Image as Desktop Background... (and preceding separator) */
          #context-sep-setbackground, #context-setDesktopBackground,

          /* Inspect Accessibility Properties */
          #context-inspect-a11y
          {
            display: none !important;
          }
          
          /* Remove space around the address box*/
          #nav-bar toolbarspring {
            min-width: 5px !important;
            max-width: 10px !important;
          }
        '';
        settings = {
          # Enable userChrome
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          
          # Performance settings
          "gfx.webrender.all" = true; # Force enable GPU acceleration
          "media.ffmpeg.vaapi.enabled" = true;
          "widget.dmabuf.force-enabled" = true; # Required in recent Firefoxes
          # Reader button
          "reader.parse-on-load.force-enabled" = true;
          # Sharing indicator
          "privacy.webrtc.legacyGlobalIndicator" = false;
          
          "app.shield.optoutstudies.enabled" = false;
          "app.update.auto" = false;
          "browser.ctrlTab.recentlyUsedOrder" = false;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.discovery.enabled" = false;
          
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.pinned" = false;
          
          # Add back the image info button
          "browser.menu.showViewImageInfo" = true;
          
          "browser.protections_panel.infoMessage.seen" = true;
          "browser.quitShortcut.disabled" = true;
          "browser.shell.checkDefaultBrowser" = false;
          
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = false;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          #betterttv
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
          #improved-tube
          istilldontcareaboutcookies
          keepassxc-browser
          link-cleaner
          return-youtube-dislikes
          search-by-image
          skip-redirect
          sponsorblock
          #stylus
          tokyo-night-v2
          tab-counter-plus
          theater-mode-for-youtube
          translate-web-pages
          unpaywall
          no-pdf-download
          youtube-shorts-block
      	  video-downloadhelper
      	  darkreader
      	  text-contrast-for-dark-themes
        ];
      };
    };
  };
}
