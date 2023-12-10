{ pkgs, ... }:

{
  programs.zsh = {
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
	home.packages = with pkgs; [ eza fishPlugins.grc grc ];
	programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

			alias cl= "clear"
			alias "cd.." = "cd .."
			alias ls = "eza --icons --git --group-directories-first"
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
		];
	};
	xdg.configFile."fish".source = ./config/fish;
}
