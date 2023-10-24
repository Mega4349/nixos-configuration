{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require 'wezterm'

      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide cleaner error messages
      if wezterm.config_builder then 
        config = wezterm.config_builder()
      end
      
      enable_kitty_graphics = true

      -- This is where you actually apply your configuration options
      --config.font_size = 10.0

      --config.colors = {
      --  background = '#111643'
      --}

      --config.window_frame = {
      --  active_titlebar_bg = '#44475A',
      --  inactive_titlebar_bg = '#44475A',
      --}

      --config.colors.tab_bar = {
      --  active_tab = {
      --    bg_color = '#111643',
      --    fg_color = '#C0C0C0',
      --  }
      --}
      
      hide_tab_bar_if_only_one_tab = true

      --config.window_background_opacity = 0.80

      -- and finally, return the configuration to wezterm
      return config
    '';
  };
} 
