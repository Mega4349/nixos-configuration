{ pkgs, ... }:

{
  programs = {
		starship = {
			enable = true;
			enableFishIntegration = true;
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
		foot = {
  	  enable = true;
  	  settings = {
    	  main = {
      	  shell = "tmux";
					font = "Maple Mono:size=9";
    			pad= "10x10";
      	};
	      cursor = {
  	      style = "block";
    	    blink = "yes"; 
    	  };
    		mouse.hide-when-typing = "yes";
      	colors = {
        	alpha = "1.0";
      		foreground = "c0caf5";
	      	background = "1a1b26";
					regular0="15161e";
					regular1="f7768e";
					regular2="9ece6a";
					regular3="e0af68";
					regular4="7aa2f7";
					regular5="bb9af7";
					regular6="7dcfff";
					regular7="a9b1d6";

					bright0="414868";
					bright1="f7768e";
					bright2="9ece6a";
					bright3="e0af68";
					bright4="7aa2f7";
					bright5="bb9af7";
					bright6="7dcfff";
					bright7="c0caf5";
  		  }; 
    	};
  	};
		tmux = {
			enable = true;
			package = pkgs.tmux-sixel;
			clock24 = true;
			extraConfig = ''
				bind-key -n C-Tab next-window
				bind-key -n C-S-Tab previous-window

				#close and open tabs
				bind-key -n C-t new-window
				bind-key -n C-w kill-window

				set -g status-right-length 150
				unbind C-b
				set -g prefix C-Space

				set -g mouse on

				unbind % # Split vertically
				unbind '"' # Split horizontally

				bind v split-window -h -c "#{pane_current_path}"
				bind h split-window -v -c "#{pane_current_path}"

				# Replace the location of the script.
				#cmus_status="#(~/Development/tokyo-night-tmux/src/cmus-tmux-statusbar.sh)"
				#git_status="#(~/Development/tokyo-night-tmux/src/git-status.sh #{pane_current_path})"

				#+--- Bars LEFT ---+
				# Session name
				set -g status-left "#[fg=black,bg=#41a6b5,bold] #S #[fg=blue,bg=default,nobold,noitalics,nounderscore]"
				#+--- Windows ---+
				# Focus
				set -g window-status-current-format "#[fg=white,bg=#1F2335]   #I #W  #{?window_last_flag,,} "
				# Unfocused
				set -g window-status-format "#[fg=brightwhite,bg=#1a1b26,nobold,noitalics,nounderscore]   #I #W #F  "

				#set-option -g status-position top

				#+--- Panes ---+
				set -g pane-border-style "fg=#3b4261"
				set -g pane-active-border-style "fg=#7aa2f7"

				# Status bar background
				set -g status-bg "#1a1b26"

				#+--- Bars RIGHT ---+
				set -g status-right "$cmus_status#[fg=white,bg=#24283B]  %Y-%m-%d #[]❬ %H:%M $git_status"
				set -g window-status-separator ""
			'';
		};
	};
}
