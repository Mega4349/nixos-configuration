{ ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "mega";
    homeDirectory = "/home/mega";
    stateVersion = "23.05";
  };
}
