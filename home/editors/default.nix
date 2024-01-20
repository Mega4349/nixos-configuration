{ ... }:

{
  imports = [
    #./emacs.nix
    ./helix.nix
    #./neovim.nix
    #./obsidian.nix
  ];
  
  home.sessionVaribales.EDITOR = "hx";
}
