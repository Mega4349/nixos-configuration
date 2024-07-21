{ pkgs, lib, ... }:

lib.mkIf (osConfig.networking.hostName == "nixos-desktop") {
  home = {
    packages = with pkgs; [
      blender-hip
      orca-slicer
      wootility
      via
      avidemux
    ];
    persistence."/nix/persist/home/mega".directories = [
      ".config/blender"
      ".config/wootility-lekker"
    ];
  };
}
