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

  configure-gtk = pkgs.writeTextFile {
  name = "configure-gtk";
  destination = "/bin/configure-gtk";
  executable = true;
  text = let
    schema = pkgs.gsettings-desktop-schemas;
    datadir = "${schema}/share/gsettings-schemas/${schema.name}";
  in ''
    export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
    gnome_schema=org.gnome.desktop.interface
    gsettings set $gnome_schema gtk-theme 'Tokyonight-Dark-BL'
    '';
  };

  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec dbus-sway-environment
    exec configure-gtk
    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
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
  
  environment.systemPackages = [ dbus-sway-environment configure-gtk pkgs.tokyo-night-gtk ];

  security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";

  environment.etc."greetd/environments".text = ''
    sway
    qtile start -b wayland
    zsh
    bash
  '';
}


