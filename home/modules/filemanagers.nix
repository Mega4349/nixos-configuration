{ pkgs, ... }:

let 
  wezterm_cwd = pkgs.writeTextFile {
    name = "wezterm_cwd";
    destination = "/bin/wezterm_cwd";
    executable = true;

    text = ''
      #!/bin/sh

      wezterm start --cwd "$PWD"
    '';
  };
  
in

{
  home.packages = with pkgs; [
    ranger
    ffmpegthumbnailer
    #poppler
    evince
    xfce.tumbler
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    cinnamon.nemo

    wezterm_cwd
  ];

  dconf.settings = {
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "wezterm_cwd";
    };
  };

  xdg.configFile = {
    "ranger/rc.conf".source = ./config/ranger/rc.conf;
    "ranger/scope.sh" = {
      source = ./config/ranger/scope.sh;
      executable = true;
    };
    #add plugins aswell

    #TODO move to separate file
    "Vencord/settings/settings.json".source = ./config/Vencord/settings/settings.json;
    "Vencord/settings/quickCss.css".source = ./config/Vencord/settings/quickCss.css; 

    "swaync".source = ./config/swaync;

    #thunar configuration
    #"xfce4/xfconf/xfce-perchannel-xml/thunar.xml".source = ./config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml;

    # btop
    "btop/btop.conf".source = ./config/btop/btop.conf;

    # obs themes
    "obs-studio/themes".source = ./config/obs-studio/themes;
  };
}
