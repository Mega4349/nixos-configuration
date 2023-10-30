{ pkgs, ... }:

let 
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
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
      gsettings set $gnome_schema gtk-theme 'Flat-Remix-GTK-Blue-Dark'
    '';
  };

in

{
  home.packages = with pkgs; [
    dbus-sway-environment
    configure-gtk
    flat-remix-gtk
    xdg-utils
    wayland
    swaybg
    waybar
    swaynotificationcenter
    autotiling
    sway-contrib.grimshot
    swayidle
    gtklock
    swappy
    autocutsel
    wl-gammactl
    wl-clipboard
    xfce.thunar
    pavucontrol
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    #XDG_SESSION_DESKTOP = "sway";
    #XDG_CURRENT_DESKTOP = "sway";

    QT_QPA_PLATFORM="wayland;xcb";
    #QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_WAYLAND_FORCE_DPI = "physical";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

    SDL_VIDEODRIVER = "wayland,x11";
    _JAVA_AWT_WM_NONPARENTING = 1;
  };

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
  
    wrapperFeatures.gtk = true;
    # may have to set env vars another way
    extraSessionCommands = ''
      export XDG_SESSION_DESKTOP=sway
      export XDG_CURRENT_DESKTOP=sway
    '';

    config = {
      bars = [{ command = "waybar"; }];

      focus= {
        followMouse = "always";
      };
    
      gaps = {
        outer = 5;
        inner = 5;
      };

      input = {
        "*" = {
          xkb_layout = "us,se";
          xkb_options = "grp:alt_caps_toggle";
        };
        pointer = {
	        accel_profile = "flat";
	        pointer_accel = "-0.15";
        }; 
	      "1102:4618:ALP0013:00_044E:120A_Touchpad" = {
	        tap = "enabled";
	        natural_scroll = "enabled";
          accel_profile = "flat";
	        pointer_accel = "-0.15";
	        dwt = "disable";
        };
      }; 

      #output = {
      #  "*".background = "~/Pictures/Wallpapers/wp2.png fill";
      #};

      seat.seat0 = {
        hide_cursor = "3000";
      };

      startup = [
        { command = "autotiling"; }
        { command = "swaync"; }
        { command = "firefox"; }
        { command = "discord-canary"; }
        { command = "nm-applet --indicator"; }
        { command = "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"; }
        { command = "autocutsel"; }
        #TODO fix { command = "swayidle -w timeout 300 'gtklock' timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' before-sleep 'gtklock'"; }
      ];

      keybindings = let 
        mod = "Mod4";
        term = "wezterm";
        menu = "anyrun";
        filemanager = "nemo";
      in {
        "${mod}+Return" = "exec ${term}";
        "${mod}+d" = "exec ${menu}";
        "${mod}+e" = "exec ${filemanager}";

        "${mod}+q" = "kill";

        "${mod}+Shift+c" = "reload";

        "${mod}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shirtcut. Do you really want to exit sway? This will end your wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

        "${mod}+s" =      	"exec grimshot --notify copy area";
        "${mod}+Shift+s" = 	"exec grimshot --notify save screen - | swappy -f -";
        "${mod}+a" =    		"exec grimshot --notify copy active";

        "${mod}+n" = "exec swaync-client -t -sw";
      
        "${mod}+Mod1+Escape" = "exec gtklock";

        "${mod}+o" = "sticky toggle";
      
        # Use $mod+[up|down|left|right] to move focus around
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # Move the focused window when adding shift
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Switch to workspace
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";
      
        # Move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";
       
        # Layout
        "${mod}+b" = "splith";
        "${mod}+v" = "splitv";
        "${mod}+x" = "layout tabbed";

        # Make focused window fullscreen
        "${mod}+f" = "fullscreen";

        # Toggle focus between the tiling area and the floating area 
        "${mod}+space" = "focus mode_toggle";

        # Toggle the current focused window bettween tiling and floating mode
        "${mod}+Shift+space" = "floating toggle";
      
        "${mod}+r" = "mode \"resize\"";
     
        # Audio
        "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
        "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
        "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
        
        # Brightness
        "XF86MonBrightnessDown" = "exec light -U 10";
        "XF86MonBrightnessUp" = "exec light -A 10";

      };

      floating.modifier = "Mod4";

      };
    
      extraConfig = ''
        output * bg ~/Pictures/Wallpapers/road.jpg fill
        bindsym --whole-window Mod4+button4 workspace prev
        bindsym --whole-window Mod4+button5 workspace next
        corner_radius 8
        blur enable
        blur_xray enable
        blur_passes 2
        blur_radius 4
        shadows enable
        layer_effects waybar shadows enable
        default_border pixel 2
        default_floating_border pixel 2
        scratchpad_minimize disable
        bindgesture swipe:right workspace prev
        bindgesture swipe:left workspace next

        # Execute on startup
        exec autotiling
        exec firefox
        exec swaync
        exec discordcanary
        exec nm-applet --indicator
        exec autocutsel
        exec swayidle -w timeout 300 'gtklock' timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output *power on"' before-sleep 'gtklock
	      exec dbus-sway-environment
        exec configure-gtk

        # Assign windows to workspaces
        assign [app_id="firefox"] 2
        assign [app_id="discord"] 3 
        assign [class="steam"] 4
        assign [app_id="transmission-gtk"] 5

        # set floating
        for_window [app_id="blueman-manager"] floating enable, resize set width 40 ppt height 30 ppt
        for_window [app_id="OpenTabletDriver.UX.Gtk"] floating enable, resize set width 60 height 55
        for_window [app_id="pavucontrol" ] floating enable, resize set width 40 ppt height 30 ppt
        for_window [class="Bluetooth-sendto" instance="bluetooth-sendto"] floating enable
        for_window [app_id="nwg-look"] floating enable, resize set width 40 ppt height 50 ppt
        for_window [window_role="pop-up"] floating enable
        for_window [window_role="bubble"] floating enable
        for_window [window_role="task_dialog"] floating enable
        for_window [window_role="Preferences"] floating enable
        for_window [window_type="dialog"] floating enable
        for_window [window_type="menu"] floating enable
        for_window [window_role="About"] floating enable
        for_window [title="File Operation Progress"] floating enable, sticky enable, resize set width 40 ppt height 30 ppt
        for_window [title="Confirm to replace files"] floating enable
        for_window [app_id="firefox" title="^Library$"] floating enable, sticky enable, resize set width 40 ppt height 30 ppt
        for_window [app_id="floating_shell_portrait"] floating enable, sticky enable, resize set width 30 ppt height 40 ppt
        for_window [title="Picture-in-Picture"] floating enable, sticky enable, border pixel 2
        for_window [title="Save File"] floating enable

        for_window [app_id="firefox" title="Firefox — Sharing Indicator"] kill

        for_window [class="steam_app_72850"] fullscreen enable

        # Inhibit idle
        for_window [app_id="firefox"] inhibit_idle fullscreen
        for_window [app_id="Chromium"] inhibit_idle fullscreen
 
        for_window [class=".*"]  border pixel 2
        for_window [app_id=".*"] border pixel 2
 
       
        # class                 border  bground text    indicator child_border
        client.focused          #7AA2F7 #7AA2F7 #F8F8F2 #7AA2F7   #7AA2F7
        client.focused_inactive #44475A #44475A #F8F8F2 #44475A   #44475A
        client.unfocused        #44475A #44475A #F8F8F2 #44475A   #44475A
        client.urgent           #FF5555 #FF5555 #F8F8F2 #FF5555   #FF5555
        client.placeholder      #44475A #44475A #F8F8F2 #44475A   #44475A
        client.background       #44475A     
      '';
  };

  xdg.configFile."gtklock/style.css".text = ''
    window {
      background: rgba(0, 0, 0, .5);
    }

    grid > label {
      color: transparent;
      margin: -20rem;
    }

    button {
      all: unset;
      color: transparent;
      margin: -20rem;
    }

    #clock-label {
      font-size: 6rem;
      margin-bottom: 4rem;
      text-shadow: 0px 2px 10px rgba(0, 0, 0, .1);
    }

    entry {
      border-radius: 16px;
      margin: 6rem;
      box-shadow: 0 1px 3px rgba(0, 0, 0, .1);
    }
  '';
}
