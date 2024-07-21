{ lib, config, pkgs, ... }:

lib.mkIf (config.networking.hostName == "nixos-desktop") {
  programs = {
    envision.enable = true;
    corectrl.enable = true;
  };
  environment.systemPackages = with pkgs; [
    wlx-overlay-s
  ];
}
