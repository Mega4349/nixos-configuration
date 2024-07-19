{ lib, config, pkgs, ... }:

{
  programs = lib.mkIf (config.networking.hostName == "nixos-desktop") {
    envision.enable = true;
    corectrl.enable = true;
  };
  services = lib.mkIf (config.networking.hostName == "nixos-desktop") {
    udev.packages = with pkgs; [
      xr-hardware
    ];
    monado = {
      enable = true;
      defaultRuntime = true; # Register as default OpenXR runtime
    };
  };
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };
  environment.systemPackages = with pkgs; lib.mkIf (config.networking.hostName == "nixos-desktop") [
    opencomposite
    usbutils
  ];
}
