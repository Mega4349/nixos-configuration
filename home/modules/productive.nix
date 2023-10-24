{ pkgs, ... }:

{
  home.packages = with pkgs; [
    blender-hip
    thunderbird
    krita
    libreoffice
    xarchiver
    unrar
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
    ];
  };

  dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
};
}
