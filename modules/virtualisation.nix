{ pkgs, ... }:

{
  virtualisation = {
    libvirtd.enable = true;
    #docker = {
    #  enable = true;
    #  storageDriver = "btrfs";
    #  rootless = {
    #    enable = true;
    #    setSocketVariable = true;
    #  };
    #};
  };
  environment.systemPackages = [ pkgs.virt-manager ];
}
