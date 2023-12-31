{ ... }:

{
  home.persistence."/nix/persist/home/mega" = {
    allowOther = true;
    directories = [
      "Desktop"
      "Downloads"
      "Pictures"
      "Music"
      "Videos"
      "Documents"
      "VMs"
      "Projects"

      ".cache"

      ".ssh"

      ".local/state/home-manager"
      ".local/state/nix"
    ];
  };
}
