{ ... }:

{
  home.persistence."/nix/persist/home/mega" = {
    allowOther = true;
    directories = [
      { directory = "Desktop"; method = "symlink"; }
      { directory = "Downloads"; method = "symlink"; }
      { directory = "Pictures"; method = "symlink"; }
      { directory = "Music"; method = "symlink"; }
      { directory = "Videos"; method = "symlink"; }
      { directory = "Documents"; method = "symlink"; }
      { directory = "VMs"; method = "symlink"; }
      { directory = "Projects"; method = "symlink"; }

      ".cache"

      ".ssh"

      ".local/state/home-manager"
      ".local/state/nix"
    ];
  };
}
