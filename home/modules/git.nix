{ pkgs, ... }:

{
	programs.git = {
    enable = true;
		package = pkgs.gitFull;
    userName  = "Mega4349";
    userEmail = "elliot.mortberg@gmail.com";
  };
}
