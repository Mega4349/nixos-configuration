{ pkgs, ...}: 

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight-night";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      keys.normal = {
        space.space = "file_picker";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
    themes = {
      # Author: Paul Graydon <p.y.graydon@gmail.com>
      tokyonight-night = let
      red = "#f7768e";
      orange = "#ff9e64";
      yellow = "#e0af68";
      light-green = "#9ece6a";
      green = "#73daca";
      turquoise = "#89ddff";
      light-cyan = "#b4f9f8";
      teal = "#2ac3de";
      cyan = "#7dcfff";
      blue = "#7aa2f7";
      magenta = "#bb9af7";
      white = "#c0caf5";
      light-gray = "#9aa5ce";
      parameters = "#cfc9c2";
      comment = "#565f89";
      black = "#414868";
      foreground = "#a9b1d6";
      foreground_highlight = "#c0caf5";
      foreground_gutter = "#363b54";
      background = "#1a1b26";
      background_highlight = "#30374b";
      background_menu = "#16161e";

      in {
      "comment" = { fg = comment; modifiers = [ "italic" ]; };
      "constant" = { fg = orange; };
      "constant.character.escape" = { fg = magenta; };
      "function" = { fg = blue; modifiers = [ "italic" ]; };
      "function.macro" = { fg = cyan; };
      "keyword" = { fg = cyan; modifiers = [ "italic" ]; };
      "keyword.control" = { fg = magenta; };
      "keyword.control.import" = { fg = cyan; };
      "keyword.operator" = { fg = turquoise; };
      "keyword.function" = { fg = magenta; modifiers = [ "italic" ]; };
      "operator" = { fg = turquoise; };
      "punctuation" = { fg = turquoise; };
      "string" = { fg = light-green; };
      "string.regexp" = { fg = light-cyan; };
      "tag" = { fg = red; };
      "type" = { fg = teal; };
      "namespace" = { fg = blue; };
      "variable" = { fg = white; };
      "variable.builtin" = { fg = red; };
      "variable.other.member" = { fg = green; };
      "variable.parameter" = { fg = yellow; modifiers = [ "italic" ]; };

      "diff.plus" = { fg = green; };
      "diff.delta" = { fg = orange; };
      "diff.minus" = { fg = red; };

      "ui.background" = { fg = foreground; bg = background; };
      "ui.cursor" = { modifiers = [ "reversed" ]; };
      "ui.cursor.match" = { fg = orange; modifiers = [ "bold" ]; };
      "ui.cursor.primary" = { modifiers = [ "reversed" ]; };
      "ui.cursorline.primary" = { bg = background_menu; };
      "ui.help" = { fg = foreground; bg = background_menu; };
      "ui.linenr" = { fg = foreground_gutter; };
      "ui.linenr.selected" = { fg = foreground; };
      "ui.menu" = { fg = foreground; bg = background_menu; };
      "ui.menu.selected" = { bg = background_highlight; };
      "ui.popup" = { fg = foreground; bg = background_menu; };
      "ui.selection" = { bg = background_highlight; };
      "ui.selection.primary" = { bg = background_highlight; };
      "ui.statusline" = { fg = foreground; bg = background_menu; };
      "ui.statusline.inactive" = { fg = foreground_gutter; bg = background_menu; };
      "ui.statusline.normal" = { fg = black; bg = blue; };
      "ui.statusline.insert" = { fg = black; bg = green; };
      "ui.statusline.select" = { fg = black; bg = magenta; };
      "ui.text" = { fg = foreground; };
      "ui.text.focus" = { fg = cyan; };
      "ui.virtual.ruler" = { bg = foreground_gutter; };
      "ui.virtual.whitespace" = { fg = foreground_gutter; };
      "ui.virtual.inlay-hint" = { fg = comment; };
      "ui.window" = { fg = black; };

      "error" = { fg = red; };
      "warning" = { fg = yellow; };
      "info" = { fg = blue; };
      "hint" = { fg = teal; };
      #"diagnostic.error" = { underline = { style = curl; color = red; }; };
      #"diagnostic.warning" = { underline = { style = curl; color = yellow; }; };
      #"diagnostic.info" = { underline = { style = curl; color = blue; }; };
      #"diagnostic.hint" = { underline = { style = curl; color = teal; }; };
      "special" = { fg = orange; };

      "markup.heading" = { fg = cyan; modifiers = [ "bold" ]; };
      "markup.list" = { fg = cyan; };
      "markup.bold" = { fg = orange; modifiers = [ "bold" ]; };
      "markup.italic" = { fg = yellow; modifiers = [ "italic" ]; };
      "markup.strikethrough" = { modifiers = [ "crossed_out" ]; };
      "markup.link.url" = { fg = green; };
      "markup.link.text" = { fg = light-gray; };
      "markup.quote" = { fg = yellow; modifiers = [ "italic" ]; };
      "markup.raw" = { fg = cyan; };
      };
    };
    languages = with pkgs;
        {
          language-server = {
            efm-lsp-prettier = {
              command = "${efm-langserver}/bin/efm-langserver";
              config = {
                documentFormatting = true;
                languages = lib.genAttrs [ "typescript" "javascript" "typescriptreact" "javascriptreact" "vue" "json" "markdown" ] (_: [{
                  formatCommand = "${nodePackages.prettier}/bin/prettier --stdin-filepath \${INPUT}";
                  formatStdin = true;
                }]);
              };
            };
            eslint = {
              command = "vscode-eslint-language-server";
              args = [ "--stdio" ];
              config = {
                validate = "on";
                packageManager = "yarn";
                useESLintClass = false;
                codeActionOnSave.mode = "all";
                # codeActionsOnSave = { mode = "all"; };
                format = true;
                quiet = false;
                onIgnoredFiles = "off";
                rulesCustomizations = [ ];
                run = "onType";
                # nodePath configures the directory in which the eslint server should start its node_modules resolution.
                # This path is relative to the workspace folder (root dir) of the server instance.
                nodePath = "";
                # use the workspace folder location or the file location (if no workspace folder is open) as the working directory

                workingDirectory.mode = "auto";
                experimental = { };
                problems.shortenToSingleLine = false;
                codeAction = {
                  disableRuleComment = {
                    enable = true;
                    location = "separateLine";
                  };
                  showDocumentation.enable = true;
                };
              };
            };

            typescript-language-server = {
              command = "${nodePackages.typescript-language-server}/bin/typescript-language-server";
              args = [ "--stdio" "--tsserver-path=${nodePackages.typescript}/lib/node_modules/typescript/lib" ];
              config.documentFormatting = false;
            };

            nil = {
              command = "${nil}.default}/bin/nil";
              config.nil = {
                formatting.command = [ "${nixpkgs-fmt}/bin/nixpkgs-fmt" ];
                # formatting.command = [ "alejandra" "-q" ];
                nix.flake.autoEvalInputs = true;
              };
            };
            rust-analyzer = {
              config.rust-analyzer = {
                cargo.loadOutDirsFromCheck = true;
                checkOnSave.command = "clippy";
                procMacro.enable = true;
                lens = { references = true; methodReferences = true; };
                completion.autoimport.enable = true;
                experimental.procAttrMacros = true;
              };
            };
          };
          language =
            let
              jsTsWebLanguageServers =
                [
                  { name = "typescript-language-server"; except-features = [ "format" ]; }
                  "eslint"
                  { name = "efm-lsp-prettier"; only-features = [ "format" ]; }
                ];
            in
            [
              {
                name = "bash";
                auto-format = true;
                file-types = [ "sh" "bash" ];
                formatter = {
                  command = "${pkgs.shfmt}/bin/shfmt";
                  # Indent with 2 spaces, simplify the code, indent switch cases, add space after redirection
                  args = [ "-i" "4" "-s" "-ci" "-sr" ];
                };
              }
              { name = "rust"; auto-format = false; file-types = [ "lalrpop" "rs" ]; language-servers = [ "rust-analyzer" ]; }

              { name = "c-sharp"; language-servers = [ "omnisharp" ]; }
              { name = "typescript"; language-servers = jsTsWebLanguageServers; }
              { name = "javascript"; language-servers = jsTsWebLanguageServers; }
              { name = "jsx"; language-servers = jsTsWebLanguageServers; }
              { name = "tsx"; language-servers = jsTsWebLanguageServers; }
              { name = "vue"; language-servers = [{ name = "vuels"; except-features = [ "format" ]; } { name = "efm-lsp-prettier"; } "eslint"]; }
              { name = "sql"; formatter.command = "pg_format"; }
              { name = "nix"; language-servers = [ "nil" ]; }
              { name = "json"; language-servers = [{ name = "vscode-json-language-server"; except-features = [ "format" ]; } "efm-lsp-prettier"]; }
              { name = "markdown"; language-servers = [{ name = "marksman"; except-features = [ "format" ]; } "ltex-ls" "efm-lsp-prettier"]; }

            ];
        };
  };

  home.packages = with pkgs; [
    nil
    lldb

    cmake-language-server
    jsonnet-language-server
    marksman # Markdown
    taplo # Toml
    pgformatter
    (python3.withPackages (ps: with ps; [ python-lsp-server ] ++ python-lsp-server.optional-dependencies.all))
    nodePackages.bash-language-server # Bash
    pyright # Python
    nodePackages.stylelint
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server # YAML / JSON
  ];
}
