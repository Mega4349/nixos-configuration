{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    # sudo alias to fix kitty fish integration
    interactiveShellInit = ''
    	set fish_greeting # Disable greeting
      
      set -U fish_features qmark-noglob
      
      alias sudo="doas"
			alias cl="clear"
			alias "cd.." "cd .."
			alias ls "eza --icons --git --group-directories-first"
    '';
    plugins = [
    	# Enable a plugin (here grc for colorized command output) from nixpkgs
    	{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
			{ name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
			{ name = "colored-man-pages"; src = pkgs.fishPlugins.autopair.src; }
		];
	};

  home = { 
		packages =  with pkgs; [
			eza
			fishPlugins.grc
			fishPlugins.autopair
			fishPlugins.colored-man-pages
			grc
		];
    persistence."/nix/persist/home/mega".directories = [
			".local/share/fish"
		];
	};

  xdg.configFile."fish/functions".source = ./config/fish/functions;
}
