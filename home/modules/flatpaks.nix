{ config, inputs, ... }:

{
  imports = [ inputs.flatpaks.homeManagerModules.default ];

  config.services.flatpak = {
    enable = true;
    enableModule = true;
    remotes = { "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo"; };
    packages = [
      "flathub:app/io.github.trigg.discover_overlay/x86_64/stable"
    ];
  };
}
