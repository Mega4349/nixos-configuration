{ pkgs, inputs, ... }:

{
  programs = {
		fish = {
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
		zsh = {
    	enable = true;
    	enableAutosuggestions = true;
    	enableCompletion = true;
    	syntaxHighlighting.enable= true;
    	shellAliases = {
      	cl = "clear";
      	"cd.." = "cd ..";
				ls = "eza -l -x --icons --git --group-directories-first";
    	};
    	oh-my-zsh = {
      	enable = true;
      	plugins = [ "git" ];
      	theme = "robbyrussell";
    	};
  	};
		starship = {
			enable = true;
			enableFishIntegration = true;
			enableZshIntegration = false;
			settings = { 
				add_newline = false;
				format = ''[](blue)$directory(fg:black bg:blue)[](blue) $git_branch$nix_shell $character'';
				directory = {	
					format = "[ 󰉋 $path ]($style)";
					style = "fg:black bg:blue";
				};
				git_branch = {
					style = "bold blue";
				};
				character = {
					success_symbol = "[ ](bold green)";
					error_symbol = "[ ](bold red)";
				};
				nix_shell = {
        	symbol = "";
        	format = " [$symbol $state( \($name\))](bold blue) ";
      	};
			};
		};
	};

	xdg.configFile."fish/functions".source = ./config/fish/functions;

	home = { 
		packages =  with pkgs; [
			eza
			fishPlugins.grc
			fishPlugins.autopair
			fishPlugins.colored-man-pages
			grc
		];
		persistence."/nix/persist/home/mega" = {
			directories = [
				".local/share/fish"
			];
			files = [
				".zsh_history"
			];
		};
	};
}
