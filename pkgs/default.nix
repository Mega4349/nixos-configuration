{ pkgs, ... }:

{
	home.packages = with pkgs; [
		(callPackage ./danser {})
		(callPackage ./spotify-adblock {})
	];
}
