# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, pkgs, ... }:

{
  imports = [(
    modulesPath + "/installer/scan/not-detected.nix"
  )];

  boot = {
    tmp.useTmpfs = true;
    initrd = {
      luks.devices."main".device = "/dev/disk/by-uuid/d40a9beb-67de-4b74-bebc-52e57546da8d";
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "amdgpu" ];
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ]; #pkgs.linuxKernel.packages.linux_6_5.amdgpu-pro pkgs.amf-headers ]; # For virtual camera in OBS
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    supportedFilesystems = [ "ntfs" ]; #For mounting windows disks
  };

	environment.systemPackages = with pkgs; [ 
    appimage-run 
    ntfs3g
  ];

  fileSystems."/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=50%" "mode=755" ];
    };

  fileSystems."/boot" = { 
      device = "/dev/disk/by-uuid/52F0-7588";
      fsType = "vfat";
    };

  fileSystems."/nix" = { 
      device = "/dev/mapper/main";
      fsType = "btrfs";
      options = [ "noatime" "subvol=nix" "compress=zstd" ];
      neededForBoot = true;
    };

  fileSystems."/nix/persist" = { 
      device = "/dev/mapper/main";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd" ];
      neededForBoot = true;
    };

  fileSystems."/nix/persist/home" = { 
      device = "/dev/mapper/main";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
      neededForBoot = true;
    };

  fileSystems."/home/mega/.osu" = {
    device = "/dev/mapper/main";
    fsType = "btrfs";
    options = [ "subvol=osu" "compress=zstd" ];
  };

  fileSystems."/home/mega/Games" = {
    device = "/dev/mapper/main";
    fsType = "btrfs";
    options = [ "subvol=games" "compress=zstd" ];
  };

  fileSystems."/home/mega/.steamlibrary" = {
    device = "/dev/mapper/main";
    fsType = "btrfs";
    options = [ "subvol=steam" "compress=zstd" ];
  };

  fileSystems."/home/mega/nixos-configuration" = { 
      device = "/nix/persist/etc/nixos";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/log" = { 
      device = "/nix/persist/var/log";
      fsType = "none";
      options = [ "bind" ];
    };

  environment.etc."machine-id".source = /nix/persist/etc/machine-id;

  fileSystems."/swap" = {
    device = "/dev/mapper/main";
    fsType = "btrfs";
    options = [ "subvol=swap" ];
    };

  #fileSystems."/run/media/mega/1TB_HDD" = {
  #  device = "/dev/disk/by-uuid/9f23adfd-8f41-4fa7-bce9-dcf0e049dbfc";
  #  fsType = "ntfs-3g";
  #  options = [ "rw" "uid=1000" ];
  #  neededForBoot = false;
  #};

  swapDevices = [{
    device = "/swap/swapfile";
    priority = 10;
    size = 20*1024;
    }];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 100;
    memoryPercent = 50;
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [
      "/nix"
      "/nix/persist"
      "/nix/persist/home"
    ];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0f0u6u4.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0f0u8.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  services.fstrim.enable = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      extraPackages = with pkgs; [
        #amdvlk
        vaapiVdpau
        libva
        libGL
      ];
      extraPackages32 = with pkgs; [
        #pkgsi686Linux.amdvlk
        driversi686Linux.vaapiVdpau
      ];
    };
  };
}
