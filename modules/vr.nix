{ lib, config, pkgs, ... }:

{
  programs = {
    envision.enable = true;
    corectrl.enable = true;
  };
  services = {
    udev.packages = with pkgs; [
      xr-hardware
    ];
    monado = lib.mkIf (config.networking.hostName == "nixos-desktop") {
      enable = true;
      defaultRuntime = true; # Register as default OpenXR runtime
    };
  };
  systemd.user.services.monado.environment = lib.mkIf (config.networking.hostName == "nixos-desktop") {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };
  environment.systemPackages = with pkgs; lib.mkIf (config.networking.hostName == "nixos-desktop") [
    opencomposite
    usbutils
  ];
}
