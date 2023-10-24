{ inputs, pkgs, ...}: # osConfig, ...}:

{
  #imports = [ inputs.anyrun.homeManagerModules.default ];  
  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        # An array of all the plugins you want, which either can be paths to the .so files, or their packages
        inputs.anyrun.packages.${pkgs.system}.applications
        #./some_plugin.so
        inputs.anyrun.packages.${pkgs.system}.shell
        #inputs.anyrun-nixos-options.packages.${pkgs.system}.default
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
      maxEntries = null;
    };
    extraCss = ''
      window {
            background: none;
      }
    '';

    #extraConfigFiles."nixos-options.ron".text = let
      #               ↓ home-manager refers to the nixos configuration as osConfig
    #  nixos-options = osConfig.system.build.manual.optionsJSON + "/share/doc/nixos/options.json";
      # merge your options
    #options = builtins.toJSON {
    #    ":nix" = [nixos-options];
    #  };
      # or alternatively if you wish to read any other documentation options, such as home-manager
      # get the docs-json package from the home-manager flake
      # hm-options = inputs.home-manager.packages.${pkgs.system}.docs-json + "/share/doc/home-manager/options.json";
      # options = builtins.toJSON {
      #   ":nix" = [nixos-options];
      #   ":hm" = [hm-options];
      #   ":something-else" = [some-other-option];
      #   ":nall" = [nixos-options hm-options some-other-option];
      # };

  #in ''
      #Config(
        # add your option paths
        #options: ${options},
        #options: ${builtins.toJSON ["${osConfig.system.build.manual.optionsJSON}/share/doc/nixos/options.json"]}
        #options: {":nix:": ["/path/to/options.json"] }, // You can obtain NixOS's options.json using config.system.build.manual.optionsJSON
        #min_score: 10, // Optional, the minimum score of entries to show. Set it to a larger value on slow machines. Default: 0
        #nixpkgs_url: "https://github.com/NixOS/nixpkgs/blob/nixos-unstable" // Optional, URL to Nixpkgs tree. Set it to use the same branch as you're using. Defaults to the unstable url.
       #)
  #'';
  };
}
