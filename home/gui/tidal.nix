{ config, ... }:

{
  programs.firefox.webapps.tidal = {
    url = "https://listen.tidal.com";
    id = 2;

    extraSettings = config.programs.firefox.profiles."mega".settings;

    icon = ./config/tidal.jpg;
    #mimeType = [ "" ];
    #categories = [ "" ];
  };
}
