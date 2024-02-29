{ inputs, pkgs, ... }:

{
  nix.gc = { 
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.05";

  environment.etc."programs.sqlite".source = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;
  
  programs.command-not-found.dbPath = "/etc/programs.sqlite";
}
