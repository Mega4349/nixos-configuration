{ pkgs, inputs, ... }:

{
  imports = [
		inputs.impermanence.nixosModules.home-manager.impermanence
    
    ./editors
    ./general
    ./gui
    ./terminal
    ./wayland
  ];
}
