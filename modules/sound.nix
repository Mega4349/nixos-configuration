{ ... }:

{
  security.rtkit.enable = true;
  
  services.pipewire = {
		enable = true;
	  alsa = {
		  enable = true;
		  support32Bit = true;
		};
	  pulse.enable = true;
	  wireplumber.enable = true;
	};

  # Only meant for ALSA configurations, set to false for pipewire
	sound.enable = false;

  hardware.pulseaudio.enable = false;
}
