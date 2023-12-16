{ pkgs, ... }:

{
  home.packages = [
    (pkgs.discord-canary.override {
      withVencord = true;
   })
		pkgs.pipewire
  ];
}
