{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu.verbatimConfig = ''
      user = "root"
      group = "root"
      remember_owner = 0
    '';
  };
}
