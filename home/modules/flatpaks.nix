{ config, inputs, ... }:

{
  imports = [ inputs.flatpak.homeManagerModules.default ];

  config.services.flatpak = {
    enableModule = true;
    remotes = { "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo"; };
    packages = [
      "flathub:app/io.github.trigg.discover_overlay/x86_64/stable"
      "flathub:app/io.missioncenter.MissionCenter/x86_64/master"
    ];
  };
}
