{ ... }:

{
	xdg.configFile."pipewire".source = ./config/pipewire;

  home.persistence."/nix/persist/home/mega".directories = [
    ".local/state/wireplumber"
  ];
}
