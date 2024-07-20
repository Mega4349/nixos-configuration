{ lib, pkgs, osConfig, ... }:

lib.mkIf (osConfig.networking.hostName == "nixos-desktop") {
	home.packages = with pkgs; [
		virt-manager
	];
	dconf.settings = {
  	"org/virt-manager/virt-manager/connections" = {
    	autoconnect = ["qemu:///system"];
    	uris = ["qemu:///system"];
  	};
	};
}
