{ lib, pkgs, ... }:

let 
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  cssStyle = pkgs.writeText "style.css" ''
    window {
      background-image: url("file:///home/mega/nixos-configuration/modules/files/trees.jpg");
      background-size: cover;
      background-position: center;
    }

    /*box * {
      background-color: rgba(50, 50, 50, 0.9);
      border-radius: 10px;
      padding: 50px;
    }
    
    button {
      color: #7AA2F7;
    }*/
  '';
in 
let 
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec dbus-sway-environment
		seat seat0 xcursor_theme Bibata-Original-Ice 24

		set $gnome-schema org.gnome.desktop.interface
		exec_always {
    	gsettings set $gnome-schema gtk-theme "Tokyonight-Dark-BL"
    	gsettings set $gnome-schema cursor-theme "Bibata-Original-Ice"
		}

    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s ${cssStyle}; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.swayfx}/bin/sway --config ${swayConfig}";
      };
    };
  };
  
  environment = {
    etc."greetd/environments".text = ''
      sway
		  fish
      zsh
      bash
    '';
    systemPackages = [ 
      dbus-sway-environment 
    ];
  };
}


