{ pkgs, ... }:

{
	home = {
		packages = with pkgs; [
			(callPackage ./danser {})
			(callPackage ./spotify-adblock {})
		];
		persistence."/nix/persist/home/mega".directories = [
			".config/danser"
			".config/spotify"

			".local/share/danser"
		];
	};
}
