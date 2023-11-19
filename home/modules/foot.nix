{ pkgs, ... }:

{
  home.packages = [ pkgs.wezterm ];
 
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono:size=9";
      	pad= "10x10";
      };
      cursor = {
        style = "block";
	      blink = "yes";
      };
      mouse.hide-when-typing = "yes";
      colors = {
        alpha = "0.8";
      	foreground = "000000";
      	background = "f7ca18";
      	regular0 = "073642";
      	regular1 = "dc322f";
      	regular2 = "859900";
      	regular3 = "b58900";
      	regular4 = "268bd2";
      	regular5 = "d33682";
	      regular6 = "2aa198";
      	regular7 = "eee8d5";
	      # TODO add bright colors
      };
    };
  };
}
