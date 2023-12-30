{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };
  home = {
    sessionPath = [ "$HOME/.config/emacs/bin" ];
    packages = with pkgs; [
      ripgrep
      fd 
      findutils

      cmake
      rnix-lsp
      clang-tools
      yaml-language-server
      vscode-langservers-extracted
    ];
    persistence."/nix/persist/home/mega".directories = [
      ".config/doom"
      ".config/emacs"
    ];
  };
}
