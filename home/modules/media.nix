{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      volume = "70";
      hwdec = "auto";
      gpu-api = "vulkan";
      gpu-context = "wayland";
      #vo = "gpu-next,gpu,dmabuf-wayland";
      ao = "pulse"; #"pipewire,pulse";
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
  home.packages = with pkgs; [
    imv
    transmission-gtk
    gimp
    avidemux
    #deadbeef-with-plugins
    miniplayer
    musikcube
    yt-dlp
    ani-cli
    manga-cli
    zathura
  ];
}
