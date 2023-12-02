{ osConfig, ... }:

{
  programs.waybar = {
    enable = true;
    
    settings = [{
      "layer" = "bottom";
      "position" = "left";

      modules-left = [ "sway/workspaces" "sway/mode" "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ ] ++ 
      (if osConfig.networking.hostName == "nixos-laptop" then 
      [ "pulseaudio" "network" "battery" "backlight" "sway/language" "tray" ]
      else [ "pulseaudio" "network`" "sway/language" "tray" ]);
      #TODO add notifications module
      
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
        "format-linked" = "󰤮 ";
        "format-wifi" = " ";
        "interval" = 1;
        "tooltip" = true;
        "tooltip-format" = "Ethernet: {ifname} \nWiFi: {essid}";
        "on-click" = "wezterm start --class floating nmtui connect";
      };
      "battery" = {
        "format" = "{icon}";
        "format-charging" = "";
        "format-icons" = [ "" "" "" "" "" ];
        "tooltip" = true;
        "tooltip-format" = "{capacity}%";
      };
       "backlight" = {
        "format" = "{icon}";
        "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
        "tooltip" = true;
        "tooltip-format" = "{percent}%";
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
/** {
    all: initial;
}*/

window#waybar {
  background: transparent;
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
}

window#waybar.hidden {
  opacity: 0.2;
}

#workspaces button {
   min-width: 0;
}

#workspaces button {
  /*font-size: 16px;*/ 
  border: none;
  border-radius: 0px;
  padding: 5 10 5 10px;
  margin: 2 2 2 2px;
  color: #A4ABCF;
}

#workspaces button.focused {
  /*font-size: 16px;*/
  background: none;
  border: 2px solid;
  border-radius: 0px;
  margin: 0 0 0 0px;
  color: #A4ABCF;
}

#workspaces button.active {
  /*font-size: 16px;*/
  background: none;
  border: 2px solid;
  border-radius: 0px;
  padding: 5 0 5 0px;
  color: #A4ABCF;
}

#workspaces button.urgent {
  background: none;
}

#workspaces button:hover {
  box-shadow: none;
  text-shadow: inherit;
  background: none;
  border: 1px solid;
  margin: 1 1 1 1px;
  transition-duration: 0.3s;
  border-radius: 0px;
  padding: 5 0 5 0px;
  color: #A4ABCF;
}

#mode {
  /* border-bottom: 3px solid #ffffff;*/
}

#clock,
#battery,
#cpu,
#memory,
#backlight,
#network,
#pulseaudio,
#tray,
#idle_inhibitor,
#custom-notification,
#language,

#window,
#workspaces {
  background: none;
  padding: 0 0 0 0px;
}

#clock {
  font-size: 16px;
  background-color: transparent;
  color: #A4ABCF;
}

#backlight {
  font-size: 18px;
  margin-right: 2px;
}

#battery {
  font-size: 16px;
  margin-right: 7px;
}

#cpu {
  font-size: 16px;
  background-color: transparent;
  color: #A4ABCF;
}

#memory {
  font-size: 16px;
  background-color: transparent;
  color: #A4ABCF;
}

#network {
  margin-top: 5px;
  margin-bottom: 5px;
  margin-left: 6px;
  color: #A4ABCF;
}

#network.disconnected {
}

#pulseaudio {
  margin-right: 6px;
  margin-top: 5px;
  margin-bottom: 5px;
  color: #A4ABCF;
}

#pulseaudio.muted {
  margin-right: 4px;
  margin-top: 5px;
  margin-bottom: 5px;
  color: #A4ABCF;
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
  /* padding: 5 0px;*/
  color: #A4ABCF;
}

#custom-notification {
  font-family: RobotoMono Nerd Font;
  font-size: 16px;
  color: #A4ABCF;
}

#language {
  font-size: 16px;
  background: none;
  color: #A4ABCF;
}
    '';
  };
}
