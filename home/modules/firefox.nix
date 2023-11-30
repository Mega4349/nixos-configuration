{ pkgs, inputs, ... }:

{
  #nixpkgs.overlays = 
  #let
    # Change this to a rev sha to pin
  #  moz-rev = "master";
  #  moz-url = builtins.fetchTarball { 
  #    url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";
  #    sha256 = "1fp637wkji0rhp12hg0hkr0nv50sqrhyf1jd4bpgj58y7wn4yjfl"; 
  #  };
  #  nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
  #in [
  #  nightlyOverlay
  #];
  
  programs.firefox = {
    enable = true;
  #  package = (pkgs.latest.firefox-nightly-bin.override { extraNativeMessagingHosts = [ inputs.pipewire-screenaudio.packages.${pkgs.system}.default ]; });
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
        #dearrow
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
        #translate-web-pages
        unpaywall
        youtube-shorts-block
      	video-downloadhelper
      	darkreader
      	text-contrast-for-dark-themes
        #inputs.pipewire-screenaudio.packages.${pkgs.system}.default
      ];
    };
  };
}
