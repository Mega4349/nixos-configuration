{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
    ffmpegthumbnailer
  ];

  xdg.configFile = {
    "ranger/plugins".source = ./config/ranger/plugins;
    "ranger/scope.sh".source = ./config/ranger/scope.sh;
    "ranger/rc.conf".source = ./config/ranger/rc.conf;
  };
}
