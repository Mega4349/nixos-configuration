{ inputs, flatpaks, ... }:

{
  #services.flatpak = {
  #  enableModule = true;
  #  remotes = { "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo"; };
  #  packages = [
  #    "flathub:app/io.github.trigg.discover_overlay//stable"
  #    "flathub:app/io.missioncenter.MissionCenter//stable"
  #  ];
  #};
  #may need overlay, cosu-trainer, danser, xwayland
}
