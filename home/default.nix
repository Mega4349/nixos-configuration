{ pkgs, inputs, buildGoModule, fetchFromGitHub, lib,  ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.anyrun.homeManagerModules.default
    #./modules/eww.nix #use eww only for logout menu, maybe
    ./modules/firefox.nix
    ./modules/anyrun.nix
    #./modules/danser.nix
    ./modules/filemanagers.nix # fix thunar configurations
    ./modules/discord.nix
    ./modules/games.nix #add aagl
    ./modules/gtk.nix
    ./modules/hyprland.nix
    ./modules/media.nix
    ./modules/ncmpcpp.nix #fix mpd not starting
    ./modules/editors.nix
    ./modules/packages.nix #combine with productive, add pavucontrol
    ./modules/productive.nix
    ./modules/qt.nix #may not be needed with stylix
    ./modules/sway.nix
    ./modules/waybar.nix #make vertical waybar
    ./modules/terminal.nix #wezterm or kitty
    ./modules/zsh.nix
  ];

  programs.home-manager.enable = true;

  #nixpkgs.overlays = [ inputs.nur.overlay ];

  home = {
    username = "mega";
    homeDirectory = "/home/mega";
    
    persistence."/nix/persist/home/mega" = {
      allowOther = true;
      directories = [
        "Desktop"
        "Downloads"
        "Pictures"
        "Music"
        "Videos"
        "Documents"
        "VMs"
        "Projects"
        #"Games" # replaced with subvolume

        ".cache"
        ".mozilla"
        ".thunderbird"

        ".config/discordcanary"
        ".config/blender"
        ".config/obs-studio"
        ".config/dconf"
        ".config/musikcube"
        ".config/transmission"
        ".config/OpenTabletDriver"
        ".config/zsh"
        ".config/wootility-lekker"
        ".config/musikcube"
        ".config/nemo"

        ".local/share/Steam"
        ".local/share/osu"
        ".local/share/nvim"
        ".local/share/mpd"
        ".local/share/PrismLauncher"
        ".local/share/honkers-railway-launhcer"

        ".local/state/nvim"
        ".local/state/wireplumber"
        ".local/state/home-manager"
        ".local/state/nix"

        ".stepmania-5.1"
        #".osu" # using another subvolume instead because I had issues with persisting this one
      ];
      files = [
        "history" #zsh command history
      ];
    };
 
    stateVersion = "23.05";
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    inputs.nur.overlay
    (final: prev: {
      xwayland = prev.xwayland.overrideAttrs (o: {
        patches = (o.patches or []) ++ [
          ../modules/files/xwayland-vsync.diff
        ];
      });
    })
    
    #https://github.com/NixOS/nixpkgs/issues/239424
    (final: prev: {
      avidemux = prev.avidemux.overrideAttrs (oldAttrs: {
        buildCommand = oldAttrs.buildCommand + ''
          mv $out/bin/avidemux $out/bin/avidemux3
          echo 'LD_LIBRARY_PATH=$(dirname $(readlink -f $(which avidemux3)))/../lib/ avidemux3 "$@"' >> $out/bin/avidemux
          chmod +x $out/bin/avidemux

          mv $out/bin/avidemux3_cli $out/bin/avidemux3_cli_old
          echo 'LD_LIBRARY_PATH=$(dirname $(readlink -f $(which avidemux3_cli)))/../lib/ avidemux3_cli_old "$@"' >> $out/bin/avidemux3_cli
          chmod +x $out/bin/avidemux3_cli
        '';
      });
    }) 
  
    #(pkgs.buildGoModule {
    #  name = "danser";
    #  src = pkgs.fetchFromGitHub {
    #    url = "https://github.com/Wieku/danser-go";
    #  };
    #})

  ];

  #buildGoModule rec {
  #  pname = "danser";
  #  version = "0.9.1";

  #  src = fetchFromGitHub {
  #    owner = "Wieku";
  #    repo = "danser-go";
  #    rev = "v${version}";
  #    hash = "";
  #  };

  #  vendorHash = lib.fakeSha256;
  #};
  
}
