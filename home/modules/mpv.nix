{ pkgs, ... }:

{
	home.packages = with pkgs; [
		yt-dlp
	];

	programs.mpv = {
    enable = true;
    #scripts = with pkgs.mpvScripts; [
    #  sponsorblock
    #  webtorrent-mpv-hook
    #  quality-menu
    #  thumbfast
    #];
    config = {
      profile = "gpu-hq";
      volume = "80";
      hwdec = "auto";
      #gpu-api = "vulkan";mis
      gpu-context = "wayland";
      vo = "gpu-next,gpu,dmabuf-wayland";
      ao = "pipewire"; #,pulse";
      scale = "ewa_lanczos";
      dscale = "ewa_robidoux";
      cscale = "mitchell";
      dither-depth = "auto";
      dither = "fruit";
      vd-lavc-film-grain = "gpu";
      #vd-lavc-av1-gpuhybrid = "gpu";
      #vd-lavc-maxframedelay = "16";
      tone-mapping = "bt.2446a";
      tone-mapping-mode = "hybrid";
      gamut-mapping-mode = "clip";
      target-trc = "bt.1886";
      alang = "jpn,jp,eng,en,enUS,en-US";
      screenshot-directory = "~/Pictures/mpv";
    };
  };
}
