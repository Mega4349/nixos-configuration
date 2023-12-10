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
      entry {
            background: #16161e;
      }
    '';
  };
}
