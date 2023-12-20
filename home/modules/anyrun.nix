        #inputs.pipewire-screenaudio.packages.${pkgs.system}.default
{ inputs, pkgs, osConfig, ...}:

{
  #imports = [ inputs.anyrun.homeManagerModules.default ];  
  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.shell
        inputs.anyrun-nixos-options.packages.${pkgs.system}.default
      ];
      width = { fraction = 0.4; };
      #position = "top";
      y = { absolute = 20; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = 7;
    };
    extraCss = ''
      window {
            background: none;
      }
      entry {
            background: #16161e;
      }
    '';
		extraConfigFiles."nixos-options.ron".text = let
      nixos-options = osConfig.system.build.manual.optionsJSON + "/share/doc/nixos/options.json";
      # merge your options
      #options = builtins.toJSON {
      #  ":nix" = [nixos-options];
      #};
      # or alternatively if you wish to read any other documentation options, such as home-manager
      # get the docs-json package from the home-manager flake
       hm-options = inputs.home-manager.packages.${pkgs.system}.docs-json + "/share/doc/home-manager/options.json";
      options = builtins.toJSON {
        ":nix" = [nixos-options];
        ":hm" = [hm-options];
      };
    in ''
      Config(
      		// add your option paths
          options: ${options},
       )
    '';
  };
}
