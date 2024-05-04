{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
		autotiling
    sway-contrib.grimshot
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "sway";
    XDG_CURRENT_DESKTOP = "sway";

    QT_QPA_PLATFORM="wayland;xcb";
    QT_WAYLAND_FORCE_DPI = "physical";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

    SDL_VIDEODRIVER = "wayland,x11";
    _JAVA_AWT_WM_NONPARENTING = 1;
  };

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
  
    wrapperFeatures.gtk = true;
    config = {
      bars = [{ command = "waybar"; }];

      focus= {
        wrapping = "yes";
        followMouse = "always";
      };
        
      gaps = {
        outer = 6;
        inner = 6;
      };

      input = {
        "*" = {
          xkb_layout = "us,se";
          xkb_options = "grp:alt_caps_toggle";
        };
        "1133:16531:Logitech_PRO_X" = { # wireless 
          accel_profile = "flat";
          pointer_accel = "-0.25";
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

      defaultWorkspace = "workspace number 1";

      # Execute on startup
      startup = [
        { command = "light -S 30"; }
        { command = "autotiling -- limit 2"; }
        { command = "firefox"; }
        { command = "swaync"; }
        { command = "vesktop"; }
        { command = "dbus-sway-environment"; }
        { command = "steam"; }
        { command = "mpdscribble"; }
        { command = "mpd-mpris"; }
        { command = "sleep 30 && killall mpd-discord-rpc && mpd-discord-rpc"; } # sleep so that discord has time to start, doesn't work if it starts after discord
        { command = "swww-daemon"; }
        { command = "sleep 1 && randomSwww ~/Pictures/Wallpapers"; }

        # Always exec when reloading sway
        { command = "killall mpd-discord-rpc && mpd-discord-rpc"; always = true; }
      ];

      keybindings = let 
        mod = "Mod4";
        term = "kitty --single-instance";
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
        "${mod}+a" =    	"exec grimshot --notify --cursor save active grimshot.png && shadowScript && copyImageScript && cleanUpScript";

        "${mod}+n" = "exec swaync-client -t -sw";
    		
        "${mod}+Mod1+Escape" = "exec swaylock -f";

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

      # Assign windows to workspaces
      assign [app_id="WebApp-anilist"] 1
      assign [app_id="firefox"] 2
      assign [app_id="vesktop"] 3
      assign [app_id="discord"] 3 
      assign [class="steam"] 4
      assign [app_id="transmission-gtk"] 5
      assign [app_id="deluge"] 5

      # set floating
      for_window [app_id="float"] floating enable

      for_window [app_id="com.obsproject.Studio"] floating enable
      for_window [app_id="qalculate-gtk"] floating enable

      for_window [app_id="blueman-manager"] floating enable, resize set width 40 ppt height 30 ppt
      for_window [app_id="OpenTabletDriver.UX.Gtk"] floating enable, resize set width 60 ppt height 75 ppt
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
      for_window [class="^.*"] inhibit_idle fullscreen
      for_window [app_id="^.*"] inhibit_idle fullscreen
      
      for_window [app_id="mpv"] inhibit_idle fullscreen
      for_window [app_id="firefox"] inhibit_idle fullscreen
      for_window [app_id="Chromium"] inhibit_idle fullscreen

      for_window [class=".*"]  border pixel 2
      for_window [app_id=".*"] border pixel 2

      for_window [app_id=".*"] corner_radius 0
      for_window [class=".*"] corner_radius 0

      for_window [app_id="io.github.seadve.Kooha"] corner_radius 12
      
      # class                 border  bground text    indicator child_border
      client.focused          #7AA2F7 #7AA2F7 #F8F8F2 #7AA2F7   #7AA2F7
      client.focused_inactive #1a1b26 #1a1b26 #F8F8F2 #1a1b26   #1a1b26
      client.unfocused        #1a1b26 #1a1b26 #F8F8F2 #1a1b26   #1a1b26
      client.urgent           #FF5555 #FF5555 #F8F8F2 #FF5555   #FF5555
      client.placeholder      #1a1b26 #1a1b26 #F8F8F2 #1a1b26   #1a1b26
      client.background       #1a1b26     
    '';
  };
}
