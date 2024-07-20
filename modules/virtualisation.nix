{ lib, pkgs, config, ... }:

lib.mkIf (config.networking.hostName == "nixos-desktop") {
  virtualisation.libvirtd = {
    enable = true;
    qemu.verbatimConfig = ''
      user = "root"
      group = "root"
      remember_owner = 0
    '';
  };
}
