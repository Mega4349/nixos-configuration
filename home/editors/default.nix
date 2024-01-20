{ ... }:

{
  imports = [
    #./emacs.nix
    ./helix.nix
    #./neovim.nix
    #./obsidian.nix
  ];
  
  home.sessionVariables.EDITOR = "hx";
}
