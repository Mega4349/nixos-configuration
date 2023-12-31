{ pkgs, ... }:

let 
  kitty_cwd = pkgs.writeTextFile {
    name = "kitty_cwd";
    destination = "/bin/kitty_cwd";
    executable = true;

    text = ''
      #!/bin/sh

      kitty --single-instance "$PWD"
    '';
  };
in
{
  home.packages = with pkgs; [
    kitty_cwd
    cinnamon.nemo
    #xfce.tumbler
    #xfce.thunar-volman
  ];

  dconf.settings = {
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "kitty_cwd";
    };
		"org/nemo/preferences" = {
			click-double-parent-folder = true;
			click-policy = "single";
			show-hidden-files = true;
			size-prefixes = "base-2";
			thumbnail-limit = "68719476735";
		};
  };

  xdg.configFile = {
    "gtk-3.0/gtk.css".text = '' 
      .nemo-window .sidebar .view {
      background-color: @theme_bg_color;
      color: @theme_fg_color;
      }
    '';
    "gtk-3.0/bookmarks".text = ''
      file:///home/mega/nixos-configuration nixos-configuration
      file:///home/mega/Music Music
      file:///home/mega/VMs VMs
      file:///home/mega/Videos Videos
      file:///home/mega/Projects Projects
      file:///home/mega/Pictures Pictures
      file:///home/mega/Downloads Downloads
      file:///home/mega/Documents Documents
    '';
  };
}
