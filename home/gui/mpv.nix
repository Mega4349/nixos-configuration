{ pkgs, ... }:

{
	home.packages = with pkgs; [
		yt-dlp
	];

	programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      sponsorblock
			mpris
			uosc
    ];
    config = {
      volume = "80";
      hwdec = "auto";
      gpu-api = "vulkan";
      gpu-context = "wayland";
      vo = "gpu-next,gpu,dmabuf-wayland";
      ao = "pipewire";
			deband = "yes";
      scale = "ewa_lanczossharp";
      dscale = "ewa_robidoux";
      cscale = "mitchell";
      dither-depth = "auto";
      dither = "fruit";
      vd-lavc-film-grain = "auto";
      tone-mapping = "bt.2446a";
      tone-mapping-mode = "hybrid";
      gamut-mapping-mode = "clip";
      target-trc = "bt.1886";
      alang = "jpn,jp,eng,en,enUS,en-US";
			force-window = "immediate";
			term-osd-bar = "yes";
			screenshot-format = "png";
      screenshot-directory = "~/Pictures/mpv";
			screenshot-png-compression = "7";
    };
		bindings = {
			g = "ignore";
			G = "add sub-scale +0.1"; # default configuration for this key, but sponsorblock steals it 
			h = "ignore";
			H = "ignore";
		};
  };
}
