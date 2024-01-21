{ pkgs, config, ... }:

{
  services = {
    mpd = {
      enable = true;
      musicDirectory = "~/Music";
      dbFile = "~/.local/share/mpd/database";
      extraConfig = ''
        port "6600" 
				
        auto_update "yes"

        audio_output {
          type     "pipewire"
          name     "MPD"
        }
				
        audio_output {
          type     "fifo"
          name     "my_fifo"
	        path     "/tmp/mpd.fifo"
          format   "44100:16:2"
        }
      '';
      network = {
        startWhenNeeded = true;
        port = 6600;
      };
    };
    mpd-discord-rpc = {
      enable = true;
      settings = {
        format = {
        details = "$title";
        state = "By $artist on $album";
        large_image = "notes";
        large_text = "$album";
        small_image = "notes";
        small_text = "$artist";
        timestamp = "elapsed";
        };
      };
    };
  };

  home = {
		packages = with pkgs; [ 
			mpc-cli 
			mpd-discord-rpc
			mpdscribble
			cava
      opusTools
  	];
		persistence."/nix/persist/home/mega".directories = [
			".mpdscribble"	
      ".config/discord-rpc"
			".local/share/mpd"
		];
	};

  programs = {
    beets = {
      enable = true;
      settings = {
        plugins = "edit fetchart lyrics web convert mpdupdate copyartifacts";
        directory = "${config.xdg.userDirs.music}";
        library = "${config.xdg.dataHome}/mpd/beetsDatabase";
        fetchart = {
          auto = "yes";
          high_resolution = "yes";
        };
        convert = {
          format = "opus";
          formats = {
            opus = {
              command = "opusenc --bitrate 192 $source $dest";
              extension = "opus";
            };
          };
        };
      };
    };
    ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override { visualizerSupport = true; outputsSupport = true; taglibSupport = true; clockSupport = true; };
      settings = {
        autocenter_mode = "yes";
        follow_now_playing_lyrics = "yes";
        ignore_leading_the = "yes";
        ignore_diacritics = "yes";
        default_place_to_search_in = "database";

        ## Display Modes ##
        playlist_editor_display_mode = "columns";
        search_engine_display_mode = "columns";
        browser_display_mode = "columns";
        playlist_display_mode = "columns";

        ## General Colors ##
        colors_enabled = "yes";
        main_window_color = "white";
        header_window_color = "cyan";
        volume_color = "green";
        statusbar_color = "white";
        progressbar_color = "cyan";
        progressbar_elapsed_color = "white";

        ## Song List ##
        song_columns_list_format = "(10)[blue]{l} (30)[green]{t} (30)[magenta]{a} (30)[yellow]{b}";
        song_list_format = "{$7%a - $9}{$5%t$9}|{$5%f$9}$R{$6%b $9}{$3%l$9}";

        ## Current Item ##
        current_item_prefix = "$(blue)$r";
        current_item_suffix = "$/r$(end)";
        current_item_inactive_column_prefix = "$(cyan)$r";

        ## Alternative Interface ##
        user_interface = "alternative";
        alternative_header_first_line_format = "$0$aqqu$/a {$6%a$9 - }{$3%t$9}|{$3%f$9} $0$atqq$/a$9";
        alternative_header_second_line_format = "{{$4%b$9}{ [$8%y$9]}}|{$4%D$9}";

        ## Classic Interface ##
        song_status_format = " $6%a $7⟫⟫ $3%t $7⟫⟫ $4%b ";
	  		
	  		## Visualizer ##
        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_output_name = "my_fifo";
        visualizer_type = "spectrum";
        visualizer_in_stereo = "yes";
        visualizer_look = "◆▋";
        visualizer_fps = 60;

        ## Navigation ##
        cyclic_scrolling = "yes";
        header_text_scrolling = "yes";
        jump_to_now_playing_song_at_start = "yes";
        lines_scrolled = "2";

        ## Other ##
        system_encoding = "utf-8";
        regular_expressions = "extended";

        ## Selected tracks ##
        selected_item_prefix = "* ";
        discard_colors_if_item_is_selected = "yes";

        ## Seeking ##
        incremental_seeking = "yes";
        seek_time = "1";

        ## Visibility ##
        header_visibility = "yes";
        statusbar_visibility = "yes";
        titles_visibility = "yes";

        ## Progress Bar ##
        progressbar_look =  "=>-";

        ## Now Playing ##
        now_playing_prefix = "> ";
        centered_cursor = "yes";

        # Misc
        display_bitrate = "yes";
        enable_window_title = "yes";
        empty_tag_marker = "";
      };
      mpdMusicDir = "~/Music";
    };
  };
}
