{ inputs, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];
  
  programs.ags.enable = true;
  
  home = {
    packages = with pkgs; [
      sassc
      inotify-tools  
      inputs.matugen.packages.${system}.default
    ];
    persistence."/nix/persist/home/mega".files = [
      ".config/ags/.env"
    ];
  };

  xdg.configFile."ags" = {
    source = ./config/ags;
    recursive = true;
  };
}
