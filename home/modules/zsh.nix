{ ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "~/.config/zsh";
    history.path = ".config/zsh/history";
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable= true;
    shellAliases = {
      cl = "clear";
     " cd.." = "cd ..";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
