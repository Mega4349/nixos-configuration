{ pkgs, ...}:

{
  home.packages = with pkgs; [
    qtile
  ];

  xdg.configFile."qtile".source = ./config/qtile;
}
