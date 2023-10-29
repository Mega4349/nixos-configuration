{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
    ffmpegthumbnailer
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman

    cinnamon.nemo
  ];

  dconf.settings = {
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "/home/mega/.config/nemo/wezterm_cwd";
    };
  };

  xdg.configFile = {
    "nemo/wezterm_cwd" = {
      text = ''
        #!/bin/sh
        wezterm start --cwd "$PWD"
      '';
      executable = true;
    };



    "ranger/rc.conf".source = ./config/ranger/rc.conf;
    "ranger/scope.sh" = {
      source = ./config/ranger/scope.sh;
      executable = true;
    };
    #add plugins aswell

    #TODO move to separate file
    "Vencord/settings/settings.json".source = ./config/Vencord/settings/settings.json;
    "Vencord/settings/quickCss.css".source = ./config/Vencord/settings/quickCss.css; 

    #thunar configuration
    #"xfce4/xfconf/xfce-perchannel-xml/thunar.xml".source = ./config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml;

    # btop
    "btop/btop.conf".source = ./config/btop/btop.conf;

    # obs themes
    "obs-studio/themes".source = ./config/obs-studio/themes;
  };
}
