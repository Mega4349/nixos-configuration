{ pkgs, ...}: {

  programs.helix = {
    enable = true;

    settings = {
      theme = "tokyonight-night";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };

    themes = {
      tokyonight-night = let
        transparent = "none";
        gray = "#414868";
        foreground = "#c0caf5";
        dark-gray = "#15161E";
        white = "#c0caf5";
        black = "#15161E";
        red = "#f7768e";
        green = "#9ece6a";
        yellow = "#e0af68";
        orange = "#fe8019";
        blue = "#7aa2f7";
        magenta = "#bb9af7";
        cyan = "#7dcfff";
      in {
        "ui.menu" = transparent;
        "ui.menu.selected" = { modifiers = [ "reversed" ]; };
        "ui.linenr" = { fg = gray; };
        "ui.popup" = { modifiers = [ "reversed" ]; };
        "ui.linenr.selected" = { fg = white;  modifiers = [ "bold" ]; };
        "ui.selection" = { fg = black; bg = blue; };
        "ui.selection.primary" = { modifiers = [ "reversed" ]; };
        "comment" = { fg = gray; };
        "ui.background" = {};
        "ui.statusline" = { fg = white; bg = dark-gray; };
        "ui.statusline.inactive" = { fg = dark-gray; bg = white; };
        "ui.help" = { fg = dark-gray; bg = white; };
        "ui.cursor" = { modifiers = [ "reversed" ]; };
        "variable" = red;
        "variable.builtin" = orange;
        "constant.numeric" = orange;
        "constant" = orange;
        "attributes" = yellow;
        "type" = yellow;
        "ui.cursor.match" = { fg = yellow; modifiers = [ "underlined" ]; };
        "string" = green;
        "variable.other.member" = red;
        "constant.character.escape" = cyan;
        "function" = blue;
        "constructor" = blue;
        "special" = blue;
        "keyword" = magenta;
        "label" = magenta;
        "namespace" = blue;
        "diff.plus" = green;
        "diff.delta" = yellow;
        "diff.minus" = red;
        "diagnostic" = { modifiers = [ "underlined" ]; };
        #"ui.gutter" = { bg = black; };
        "ui.text" = { fg = foreground; };
        "info" = blue;
        "hint" = dark-gray;
        "debug" = dark-gray;
        "warning" = yellow;
        "error" = red;
      };
    };
  };
}


