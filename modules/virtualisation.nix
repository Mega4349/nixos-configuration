{ lib, pkgs, config, ... }:

{
  virtualisation = {
    waydroid.enable = true;
    libvirtd = lib.mkIf (config.networking.hostName == "nixos-desktop") {
      enable = true;
      qemu.verbatimConfig = ''
        user = "root"
        group = "root"
        remember_owner = 0
      '';
    };
  };
  environment.systemPackages = with pkgs; [
    lzip
  ];
}
