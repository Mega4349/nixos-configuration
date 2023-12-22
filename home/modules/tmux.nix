{ pkgs, ... }:

{
	nixpkgs.overlays = [
		(self: super: {
			tmux-sixel = self.tmux.overrideAttrs (super: {
				configureFlags = (super.configureFlags or []) ++
				  ["--enable-sixel"];
				src = pkgs.fetchFromGitHub {
  				owner = "tmux"; 
    			repo = "tmux"; 
  				rev = "bdf8e614af34ba1eaa8243d3a818c8546cb21812"; 
  				hash = "sha256-ZMlpSOmZTykJPR/eqeJ1wr1sCvgj6UwfAXdpavy4hvQ="; 
				};
				patches = [];
			});
		})
	];

	programs.tmux = {
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
}
