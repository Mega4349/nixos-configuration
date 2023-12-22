{ pkgs, inputs, ... }:

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

  shadowScript = pkgs.writeTextFile {
    name = "shadowScript";
    destination = "/bin/shadowScript";
    executable = true;

    text = ''
      convert -page +30+30 grimshot.png -alpha set \
          \( +clone -background black -shadow 80x20+0+0 \) +swap \
          -background none -mosaic screenshot.png
    '';
  };

  cleanUpScript = pkgs.writeTextFile {
    name = "cleanUpScript";
    destination = "/bin/cleanUpScript";
    executable = true;

    text = '' 
      rm grimshot.png rounded.png
    '';
  };

  copyImageScript = pkgs.writeTextFile {
    name = "copyImageScript";
    destination = "/bin/copyImageScript";
    executable = true;

    text = ''
      wl-copy -t image/png < screenshot.png
    '';
  };

  roundedShadowScript = pkgs.writeTextFile {
    name = "roundedShadowScipt";
    destination = "/bin/roundedShadowScript";
    executable = true;

    text = ''
      convert grimshot.png \
      \( +clone  -alpha extract \
        -draw 'fill black polygon 0,0 0,10 10,0 fill white circle 10,10 10,0' \
        \( +clone -flip \) -compose Multiply -composite \
        \( +clone -flop \) -compose Multiply -composite \
      \) -alpha off -compose CopyOpacity -composite  rounded.png

      convert -page +15+15 rounded.png -alpha set \
          \( +clone -background black -shadow 80x6+0+0 \) +swap \
          -background none -mosaic screenshot.png
    '';
  };

in

{
  home.packages = with pkgs; [
    dbus-sway-environment
    shadowScript
    roundedShadowScript
    cleanUpScript
    copyImageScript
    xdg-utils
    wayland
    swww
    waybar
    swaynotificationcenter
    autotiling
    sway-contrib.grimshot
    swayidle
    gtklock
    wlogout
    swappy
    copyq
    wl-gammactl
    wl-clipboard
    pavucontrol
    wlopm
    imagemagick
    pamixer
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    #XDG_SESSION_DESKTOP = "sway";
    XDG_CURRENT_DESKTOP = "sway";

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

    extraSessionCommands = ''
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
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
          xkb_layout = "us,se,canary";
          xkb_options = "grp:alt_caps_toggle";
        };
        "1133:16531:Logitech_PRO_X" = { # wireless 
          accel_profile = "flat";
          pointer_accel = "-0.15";
        }; 
				"1133:49300:Logitech_PRO_X_Wireless" = { # wired mode, ironically
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

      seat.seat0 = {
        hide_cursor = "3000";
      };

      keybindings = let 
        mod = "Mod4";
        term = "footclient";
        menu = "anyrun";
        filemanager = "nemo";
      in {
        "${mod}+Return" = "exec ${term}";
        "${mod}+d" = "exec ${menu}";
        "${mod}+e" = "exec ${filemanager}";

        "${mod}+q" = "kill";

        "${mod}+Shift+c" = "reload";

        "${mod}+Shift+e" = "exec wlogout -p layer-shell -b 5 -T 400 -B 400"; #TODO, not hardcoded pixel values

        "${mod}+s" =      	"exec grimshot --notify save area grimshot.png && roundedShadowScript && copyImageScript && cleanUpScript";
        "${mod}+Shift+s" = 	"exec grimshot --notify --cursor save screen - | swappy -f -";
        "${mod}+a" =    	"exec grimshot --notify save active grimshot.png && shadowScript && copyImageScript && cleanUpScript";

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
        #"${mod}+0" = "workspace number 10";
      
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
        "XF86AudioRaiseVolume" = "exec 'pamixer -i 5'";
        "XF86AudioLowerVolume" = "exec 'pamixer -d 5'";
        "XF86AudioMute" = "exec 'pamixer -t'";
        
        # Brightness
        "XF86MonBrightnessDown" = "exec light -U 10";
        "XF86MonBrightnessUp" = "exec light -A 10";
      };

      floating.modifier = "Mod4";

      };
    	
      extraConfig = ''
        bindsym Mod4+0 workspace number 10 #Hopefully fixes sway starting on workspace 10

        exec swww init && swww img ~/nixos-configuration/modules/files/trees.jpg

        bindsym --whole-window Mod4+button4 workspace prev
        bindsym --whole-window Mod4+button5 workspace next
        corner_radius 0
        blur enable
        blur_xray enable
        blur_passes 2
        blur_radius 4
        shadows enable
        default_border pixel 2
        default_floating_border pixel 2
        scratchpad_minimize disable
        bindgesture swipe:right workspace prev
        bindgesture swipe:left workspace next

        # Execute on startup
        exec autotiling --limit 2
        exec firefox
        exec swaync
        exec discordcanary
        exec deluge
        exec copyq
        exec dbus-sway-environment
        exec steam
				exec foot --server
				exec mpdscribble

        # Assign windows to workspaces
        assign [app_id="firefox"] 2
        assign [app_id="discord"] 3 
        assign [class="steam"] 4
        assign [app_id="transmission-gtk"] 5
        assign [app_id="deluge"] 5

        # set floating
        for_window [app_id="float"] floating enable

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
        client.focused_inactive #1a1b26 #1a1b26 #F8F8F2 #1a1b26   #1a1b26
        client.unfocused        #1a1b26 #1a1b26 #F8F8F2 #1a1b26   #1a1b26
        client.urgent           #FF5555 #FF5555 #F8F8F2 #FF5555   #FF5555
        client.placeholder      #1a1b26 #1a1b26 #F8F8F2 #1a1b26   #1a1b26
        client.background       #1a1b26     

        layer_effects "waybar" shadows enable;
      '';
  };

  xdg.configFile = {
    "gtklock/style.css".text = ''
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
        border-radius: 0px;
        margin: 6rem;
        box-shadow: 0 1px 3px rgba(0, 0, 0, .1);
      }
    '';

    "wlogout/style.css".text = ''
      window {
        font-size: 12pt;
        color: #cdd6f4; 
        background-color: rgba(30, 30, 46, 0.5);
      }

      button {
        background-repeat: no-repeat;
        background-position: center;
        background-size: 20%;
        border: none;
        color: #ced7f4;
        text-shadow: none;
        background-color: rgba(30, 30, 46, 0);
        margin: 5px;
        transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
      }

      button:hover {
        background-color: rgba(49, 50, 68, 0.1);
      }

      button:focus {
        background-color: #7aa7f2;
        color: #18182a;
        text-shadow: none;
      }

      #lock {
        background-image: image(url("./images/lock.png"));
      }
      #lock:focus {
        background-image: image(url("./images/lock-hover.png"));
      }

      #logout {
        background-image: image(url("./images/logout.png"));
      }
      #logout:focus {
        background-image: image(url("./images/logout-hover.png"));
      }

      #suspend {
        background-image: image(url("./images/sleep.png"));
      }
      #suspend:focus {
        background-image: image(url("./images/sleep-hover.png"));
      }

      #shutdown {
        background-image: image(url("./images/power.png"));
      }
      #shutdown:focus {
        background-image: image(url("./images/power-hover.png"));
      }

      #reboot {
        background-image: image(url("./images/restart.png"));
      }
      #reboot:focus {
        background-image: image(url("./images/restart-hover.png"));
      }
    '';

    "wlogout/layout".text = ''
      {
        "label" : "lock",
        "action" : "gtklock",
        "text" : "Lock",
        "keybind" : "l"
      }
      {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
      }
      {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Shutdown",
        "keybind" : "s"
      }
      {
        "label" : "logout",
        "action" : "swaymsg exit",
        "text" : "Logout",
        "keybind" : "e"
      }
      {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Suspend",
        "keybind" : "u"
      }
    '';

    "wlogout/images".source = ./config/wlogout/images;

    #"xdg-desktop-portal-luminous/config.toml".text = ''
    #  color_scheme = "dark" # can also be "light"
    #  accent_color = "#7aa2f7"
    #'';

    #"xdg-desktop-portal/sway-portals.conf".text = ''
    #  [preferred]
    #  default=wlr;gtk
    #  org.freedesktop.impl.portal.FileChooser=gtk
    #'';
  };

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.gtklock}/bin/gtklock"; }
      #{ event = "lock"; command = "lock"; }
      #{ event = "after-resume"; command = "${pkgs.gtklock}/bin/gklock"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.gtklock}/bin/gtklock"; }
      { timeout = 600; command = "${pkgs.wlopm}/bin/wlopm --off \*"; resumeCommand = "${pkgs.wlopm}/bin/wlopm --on \*"; } #TODO fix \* not working for outputs
    ];
  };
}
