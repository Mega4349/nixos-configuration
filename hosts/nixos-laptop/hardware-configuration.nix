# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
		initrd = {
		luks.devices."main".device = "/dev/disk/by-uuid/c13530c1-43c9-4556-bcd0-c52a8e85d14a";
			availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  		kernelModules = [ ];
		};
  	kernelModules = [ "kvm-intel" ];
  	extraModulePackages = [ ];
  	kernelPackages = pkgs.linuxPackages_latest;
		binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  	supportedFilesystems = [ "ntfs" ];
	};

	environment.systemPackages = [ pkgs.appimage-run ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=50%" "mode=755" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CC2C-9EF2";
    fsType = "vfat";
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/main";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" ];
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

  fileSystems."/home/mega/.steamlibrary" = {
    device = "/dev/mapper/main";
    fsType = "btrfs";
    options = [ "subvol=steam" "compress=zstd" ];
  };

  #fileSystems."/var/log" =
  #  { device = "/nix/persist/var/log";
  #    fsType = "none";
  #    options = [ "bind" ];
  #  };

  environment.etc = {
    "machine-id".source = "/nix/persist/etc/machine-id";
    "hashedPasswordFile".source = "/nix/persist/etc/hashedPasswordFile";
  };

  fileSystems."/home/mega/nixos-configuration" = {
    device = "/nix/persist/etc/nixos";
    fsType = "none";
    options = [ "bind" ];
  };

#  fileSystems."/swap" = {
#    device = "/dev/mapper/main";
#    fsType = "btrfs";
#    options = [ "subvol=swap" ];
#  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 100;
    memoryPercent = 50;
  };

#  swapDevices = [{
#    device = "/swap/swapfile";
#    priority = 10;
#    size = 12*1024;
#  }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;
  services = {
		fstrim.enable = lib.mkDefault true;
		
		tlp = {
    	enable = true;
    	settings = {
      	CPU_BOOST_ON_AC = 1;
      	CPU_BOOST_ON_BAT = 0;
      	CPU_SCALING_GOVERNOR_ON_AC = "performance";
      	CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
		  };
  	};
  	# Disable GNOMEs power management
  	power-profiles-daemon.enable = false;
  	# Enable thermald (only necessary if on Intel CPUs)
  	thermald.enable = true;
	};
	
	# Enable powertop
  powerManagement.powertop.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        libGL
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ 
        vaapiIntel 
        intel-vaapi-driver
      ];
    };
  };
}
