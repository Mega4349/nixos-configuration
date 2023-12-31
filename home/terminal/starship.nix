{ ... }:

{
  programs.starship = {
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
}
