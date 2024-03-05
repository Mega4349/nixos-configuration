{ config, ... }:

{
  programs.firefox.webapps.anilist = {
    url = "https://anilist.co/home";
    id = 1;
    
    extraSettings = config.programs.firefox.profiles."mega".settings;

    icon = ./config/anilist.jpg;
    #mimeType = [ "" ];
    #categories = [ "" ];
  };
}
