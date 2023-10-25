{ pkgs, inputs, ... }:

{
 # imports = [ inputs.hyprland.homeManagerModules.default ];

  home.packages = with pkgs; [
    xdg-desktop-portal-hyprland
    grimblast
    hyprpaper
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = swaync
      exec-once = hyprpaper
      exec-once = discordcanary & firefox
      exec-once = waybar

      exec-once = ${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland

      input {
        kb_layout = us,se,canary
        kb_options = gpr:alt_caps_toggle

        follow_mouse = 1
    
        accel_profile = flat
        sensitivity = 0 
      }

      input {
        kb_layout = us,se,canary
        kb_options = grp:alt_caps_toggle
      }

      general {
        gaps_in = 4
        gaps_out = 8
        border_size = 2
        col.active_border = rgba(7aa2f7ee) rgba(1a4ab2ee) 45deg
        col.inactive_border = rgba(24283bee)

        layout = master
        cursor_inactive_timeout = 3
      }

      master {
        new_is_master = no
      }

      decoration {
        rounding = 0 #4
        multisample_edges = yes
        blur {
          enabled = yes
          size = 3
          passes = 1 
          new_optimizations = yes
          xray = yes
        }
        #blur = yes
        #blur_size = 3
        #blur_passes = 2
        #blur_new_optimizations = on
        multisample_edges = true

        drop_shadow = yes
        shadow_range = 15
        shadow_render_power = 2
        col.shadow = rgba(1a1a1aee)

        #dim_inactive = true
        dim_strength = 0.25
      }

      animations {
        enabled = yes

        bezier = windowBezier, 0.21, 0.97, 0.1, 1.05
        bezier = workspaceBezier, 0.21, 0.97, 0.1, 1.05
        bezier = fadeSwitchBezier, 0.37, 0, 0.63, 1
        bezier = windowMoveBezier, 0.16, 1, 0.3, 1

        animation = windowsIn, 1, 6, windowBezier, slide
        animation = windowsOut, 1, 5, default, slide
        animation = windowsMove, 1, 6, windowMoveBezier
        animation = workspaces, 1, 6, workspaceBezier, slidevert
        animation = fade, 1, 7, default
        animation = fadeSwitch, 1, 7, fadeSwitchBezier

        #bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        #animation = windows, 1, 7, myBezier
        #animation = windowsOut, 1, 7, default, popin 80%
        #animation = border, 1, 10, default
        #animation = borderangle, 1, 8, default
        #animation = fade, 1, 7, default
        #animation = workspaces, 1, 6, default
      }

      misc {
        disable_hyprland_logo = true
      }

      # Keybinds

# Set Super as the mod key
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Return, exec, wezterm
bind = $mainMod, Q, killactive, 
bind = $mainMod, M, exit, 
bind = $mainMod, E, exec, thunar
bind = $mainMod SHIFT, Space, togglefloating, 
bind = $mainMod, D, exec, anyrun       #wofi --show drun
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with Mod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with Mod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with Mod + scroll
bind = $mainMod, mouse_down, workspace, e-1
bind = $mainMod, mouse_up, workspace, e+1

# Move/resize windows with Mod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Make a window fullscreen with Mod + F 
bind = $mainMod, F, fullscreen

# Open swaync notification center
bind = $mainMod SHIFT, N, exec, swaync-client -t -sw

# Lock screen
bind = SUPER ALT, escape, exec, swaylock -f

# Screenshot keybinds
# bind = $mainMod, S, exec, XDG_CURRENT_DESKTOP=Sway flameshot gui 
bind = $mainMod, S, exec,	grimblast --notify copy area
bind = $mainMod SHIFT, S, exec,	grimblast --notify save screen - | swappy -f -
bind = $mainMod, A, exec,	grimblast --notify save active - | swappy -f -
bind = $mainMod SHIFT, A, exec,	grimblast --notify save output - | swappy -f -

# Pin a floating window/show on all workspaces
bind = $mainMod, O, pin

# Emoji picker
bind $mainMod ALT, E, exec, emote

# 
bind = ALT, S, exec, hyprctl switchxkblayout wooting-wooting-60he-(arm) next

# 
bind = $mainMod SHIFT, E, exec, home/mega/.config/waybar/scripts/power-menu.sh

# scratchpad 
bind = SUPER SHIFT, G, movetoworkspace, special
bind = SUPER, G, togglespecialworkspace,

bind = ALT,F10, pass, ^(com\.obsproject\.Studio)$

# will switch to a submap called resize
bind=SUPER,R,submap,resize

# will start a submap called "resize"
submap=resize

# sets repeatable binds for resizing the active window
binde=,right,resizeactive,10 0
binde=,left,resizeactive,-10 0
binde=,up,resizeactive,0 -10
binde=,down,resizeactive,0 10

# use reset to go back to the global submap
bind=,escape,submap,reset 

# will reset the submap, meaning end the current one and return to the global one
submap=reset

# keybinds further down will be global again...


# Window Rules 
windowrule = fullscreen,^(osu!)$
windowrule = float,^(OpenTabletDriver.UX.Gtk)$
windowrule = maxsize 800 600,^(bolero01sys.exe)$
windowrule = workspace: 2,^(firefox)$
windowrule = float,^(pavucontrol)$
windowrule = float,^(KeyOverlay)$
windowrule = workspace: 3, ^(discord)$
windowrule = workspace: 4, ^(steam)$
windowrule = workspace: 5, ^(org.qbittorrent.qBittorrent)$
windowrule = noanim, ^(flameshot)$
#windowrule = workspace: 7, ^(Spotify)$
#windowrule = workspace: 7, ^(steam)$

#windowrule = workspace: 9, ^(discord)$
#windowrule = workspace: 8, ^(Spotify)$
#windowrule = workspace: 7, ^(steam)$
windowrule = float,title:^(Picture-in-Picture)$
windowrule = pin,title:^(Picture-in-Picture)$
windowrule = maxsize: 480 270,title:^(Picture-in-Picture)$
windowrule = float,title:^(File Operation Progress)$
windowrule = float,title:^(Confirm to replace files)$

 windowrulev2 = float, class:floating 

windowrule = pin, ^(mpv)$
windowrule = keepaspectratio, ^(mpv)$
windowrule = float, ^(mpv)$
windowrule = size 55% 55%, ^(mpv)$
# swaylock
# powermeny
# new launcher
# theming
# cursors
# sticky toggle? 
# kb layout+ in waybar
# make picture in picture floatin
# sddm

    #'';
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/Wallpapers/main.jpeg
    wallpaper = HDMI-A-1,~/Pictures/Wallpapers/main.jpeg
  '';
}
