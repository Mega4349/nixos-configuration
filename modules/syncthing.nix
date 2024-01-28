{ ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/home/mega";
    configDir = "/home/mega/.config/syncthing";
    user = "mega";
    group = "users";
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;
    overrideDevices = true;
    overrideFolders = true;
  };
}
