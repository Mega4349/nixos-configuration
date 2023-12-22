{ pkgs, ... }:

{
	xdg.configFile = {
    "ranger/rc.conf".source = ./ranger/rc.conf;
    "ranger/scope.sh" = {
      source = ./ranger/scope.sh;
      executable = true;
    };
		"ranger/plugins".source = ./ranger/plugins;

    #TODO move to separate file
    "Vencord/settings/settings.json".source = ./Vencord/settings/settings.json;
    "Vencord/settings/quickCss.css".source = ./Vencord/settings/quickCss.css; 

    "swaync".source = ./swaync;

    # btop
    "btop/btop.conf".source = ./btop/btop.conf;

    # obs themes
    "obs-studio/themes".source = ./obs-studio/themes;
  };
}
