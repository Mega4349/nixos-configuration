{ ... }:

{
  programs.waybar = {
    enable = true;
    
    #systemd.enable = true;

    settings = [{
      "layer" = "top";
      "position" = "left";
      "exclusive" = "no";

      modules-left = [ "sway/workspaces" "sway/mode" "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "network" "sway/language" "hyprland/language" "tray" ];
      
      "hyprland/workspaces" = {
        "format" = "{icon}";
        "on-click" = "activate";
        "on-scroll-up" = "hyprctl dispatch workspace e-1";
        "on-scroll-down" = "hyprctl dispatch workspace e+1";
        "format-icons" = { 
          "1" = "一"; 
          "2" = "二"; 
          "3" = "三"; 
          "4" = "四"; 
          "5" = "五"; 
          "6" = "六"; 
          "7" = "七"; 
          "8" = "八";
          "9" = "九";
          "10" = "十";
        };
      };

      "sway/workspaces" = {
        "format" = "{icon}";
        #"on-click" = "activate";
        #"on-scroll-up" = "hyprctl dispatch workspace e-1";
        #"on-scroll-down" = "hyprctl dispatch workspace e+1";
        "format-icons" = { 
          "1" = "一"; 
          "2" = "二"; 
          "3" = "三"; 
          "4" = "四"; 
          "5" = "五"; 
          "6" = "六"; 
          "7" = "七"; 
          "8" = "八";
          "9" = "九";
          "10" = "十";
        };
      };

      "clock" = {
        "format" = "{:%H\n%M}";
        "tooltip" = true;
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon}";
        "format-muted" = "󰖁 ";
        "format-icons" = {
          "default" = [ "" "" "" ];
        };
        "on-click" = "pavucontrol";
        "tooltip" = true;
        "tooltip-format" = "{icon}  {volume}%";
      };
      "network" = {
        "format-disconnected" = "󰯡 ";
        "format-ethernet" = "󰀂 ";
        "format-linked" = "󰖪 ";
        "format-wifi" = "󰖩 ";
        "interval" = 1;
        "tooltip" = true;
        "tooltip-format" = "Ethernet: {ifname} \nWiFi: {essid}";
        "on-click" = "wezterm start --class floating nmtui connect";
      };
      "cpu" = {
        "interval" = 3;
        "format" = "\n";
        "tooltip-format" = "󰍛 {percentage}%";
      };
      "memory" = {
        "interval" = 5;
        "format" = "\n";
        "tooltip-format" = "{percentage}%";
      };
      "sway/language" = {
        "format" = "{short}";
      };
      "hyprland/language" = {
        "format" = "{short}";
      };
      "tray" = {
        "icon-size" = 18;
        "spacing" = 7; 
      };
    }];

    style = ''
window#waybar {
  background: transparent;
  border-radius: 0px;
}

window > box {
  margin-top: 8px;
  margin-left: 8px;
  margin-bottom: 8px;
  color: #a4abcf;
  border: 2px solid;
  background: #16161e;
  transition-property: color;
  transition-duration: 0s;
  box-shadow: 0 0 3px #151515;
}

window#waybar.hidden {
  opacity: 0.2;
}

#workspaces button {
  font-size: 16px; 
  border: none;
}

#workspaces button.focused {
  font-size: 16px;
  background: none;
  border: 2px solid;
}

#workspaces button.active {
  font-size: 16px;
  background: none;
  border: 2px solid;
}

#workspaces button.urgent {
  background: none;
}

#workspaces button:hover {
  box-shadow: none;
  text-shadow: inherit;
  background: none;
  border: 1px solid;
  transition-duration: 0.3s;
  /*padding: 0 3px;*/
}

#mode {
  /* border-bottom: 3px solid #ffffff;*/
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#custom-gpu_usage,
#custom-notification,
#language,
#mpd {
  padding: 0 10px;
}

#window,
#workspaces {
  background: none;
}

#clock {
  font-size: 16px;
  background-color: transparent;
}

label:focus {
}

#cpu {
  font-family: RobotoMono Nerd Font;
  font-size: 16px;
  background-color: transparent;
}

#memory {
  font-family: RobotoMono Nerd Font;
  font-size: 16px;
  background-color: transparent;
}

#network {
  margin-top: 5px;
  margin-bottom: 5px;
  margin-left: 3px;
}

#network.disconnected {
}

#pulseaudio {
  margin-right: 6px;
  margin-top: 5px;
  margin-bottom: 5px;
}

#pulseaudio.muted {
  margin-right: 6px;
  margin-top: 5px;
  margin-bottom: 5px;
}

#wireplumber {
  background-color: transparent;
}

#wireplumber.muted {
  background-color: transparent;
}

#custom-media {
  min-width: 100px;
}

#custom-media.custom-spotify {
}

#custom-media.custom-vlc {
}

#temperature {
}

#temperature.critical {

}

#tray {
  margin-top: 5px;
  margin-bottom: 8px;
}

#tray > .passive {
  -gtk-icon-effect: dim;
}

#tray > .needs-attention {
  -gtk-icon-effect: highlight;

}

#idle_inhibitor {

}

#idle_inhibitor.activated {


}

#language {
  font-family: RobotoMono Nerd Font;
  font-size: 16px;


  min-width: 20px;
  /*margin: 0px;*/
  /* padding: 5 0px;*/
}

#keyboard-state {
  padding: 0 0px;
  margin: 0 5px;
  min-width: 16px;
}

#keyboard-state > label {
  padding: 0 5px;
}

#keyboard-state > label.locked {
  background: rgba(0, 0, 0, 0.2);
}

#scratchpad {
  background: rgba(0, 0, 0, 0.2);
}

#scratchpad.empty {
  background-color: transparent;
}

#custom-gpu_usage {
  font-family: RobotoMono Nerd Font;
  font-size: 16px;

}

#custom-notification {
  font-family: RobotoMono Nerd Font;
  font-size: 16px;

}

#language {
  font-family: RobotoMono Nerd Font;
  font-size: 16px;
  background: none;

}
    '';
  };
}
