{ pkgs, inputs, ... }:

{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    image = ./files/road.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    fonts = {
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      };
      sizes = {
        terminal = 10;
      };
    };
    opacity = {
      terminal = 0.80;
    };
  };

}
