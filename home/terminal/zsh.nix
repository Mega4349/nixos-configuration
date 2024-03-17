{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
  	enableCompletion = true;
    autosuggestion.enable = true;
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

  home = { 
		packages =  with pkgs; [
			eza
		];
    persistence."/nix/persist/home/mega".files = [
			".zsh_history"
		];
	};
}
