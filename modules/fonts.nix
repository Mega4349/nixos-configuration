{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      font-awesome
      
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      jetbrains-mono

      unifont
      
			maple-mono
    ];
    fontconfig.defaultFonts = {
      monospace = [ "Maple Mono" ];
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };
}
