{ pkgs, inputs, ... }:

{
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim
  ];

  xdg.configFile = {
    #"nvim".source = ./config/nvim;
  };

  programs.nixvim = {
    enable = true;
    options = {
      number = true;
      shiftwidth = 2;
    };
    colorschemes.tokyonight = {
      enable = true;
      style = "night";
      transparent = true;
    };
    viAlias = true;
    vimAlias = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    plugins = {
      neo-tree = {
        enable = true;
	filesystem.filteredItems = {
	  hideDotfiles = false;
	  hideGitignored = false;
	};
	window.width = 28;
      };
      lualine = {
	enable = true;
      };
    };
    keymaps = [
      {
        mode = "n";
	key = "<leader>e";
	action = "<cmd>Neotree toggle<cr>";
      }
    ];
    extraConfigVim = ''
      highlight NeoTreeNormal guibg=none
      highlight NeoTreeNormal ctermbg=none
      highlight NeoTreeNormalNC guibg=none
      highlight NeoTreeNormalNC ctermbg=none
    '';
    enableMan = false;
  };

  #programs.neovim = {
  #  enable = true;
  #  defaultEditor = true;

  #  viAlias = true;
  #  vimAlias = true;
  #  vimdiffAlias = true;

    #withPython3 = true;
    #withNodeJs = true;
    #extraPackages = with pkgs; [];

    #plugins = with pkgs.vimPlugins; [
      # search all the plugins using https://search.nixos.org/packages
      # git stuff
      #vim-fugitive
      #vim-rhubarb
      
      # tabstop shiftwidth
      #vim-sleuth

      #{
      #  plugin = indent-blankline-nvim;
      #  type = "lua";
      #  config = ''opts = {
      #    indent = { char = "▏" },
      #    scope = { show_start = false, show_end = false },
      #    exclude = {
      #      buftypes = {
      #        "nofile",
      #        "terminal",
      #      },
      #    },
      #  }'';
      #}
    #];
  #};
  
  home = {
    packages = with pkgs;
      [
        #-- c/c++
        cmake
        cmake-language-server
        gnumake
        checkmake
        gcc # c/c++ compiler, required by nvim-treesitter!
        llvmPackages.clang-unwrapped # c/c++ tools with clang-tools such as clangd
        gdb
        #lldb

        #-- python
        nodePackages.pyright # python language server
        python311Packages.black # python formatter
      	ruff
        #python311Packages.ruff-lsp

        #-- rust
        rust-analyzer
        cargo # rust package manager
        rustfmt

        #-- zig
        #zls

        #-- nix
        nil
        rnix-lsp
        # nixd
        statix # Lints and suggestions for the nix programming language
        deadnix # Find and remove unused code in .nix source files
        alejandra # Nix Code Formatter

        #-- golang
        #go
        #gomodifytags
        #iferr # generate error handling code for go
        #impl # generate function implementation for go
        #gotools # contains tools like: godoc, goimports, etc.
        #gopls # go language server
        #delve # go debugger

        #-- lua
        stylua
        lua-language-server

        #-- bash
        nodePackages.bash-language-server
        shellcheck
        shfmt

        #-- javascript/typescript --#
        nodePackages.typescript
        nodePackages.typescript-language-server
        # HTML/CSS/JSON/ESLint language servers extracted from vscode
        nodePackages.vscode-langservers-extracted
        nodePackages."@tailwindcss/language-server"

        nodejs
	 
        #-- CloudNative
        #nodePackages.dockerfile-language-server-nodejs
        #terraform
        #terraform-ls
        #jsonnet
        #jsonnet-language-server
        #hadolint # Dockerfile linter

        #-- Others
        taplo # TOML language server / formatter / validator
        nodePackages.yaml-language-server
        sqlfluff # SQL linter
        actionlint # GitHub Actions linter
        buf # protoc plugin for linting and formatting
        proselint # English prose linter

        #-- Misc
        tree-sitter # common language parser/highlighter
        nodePackages.prettier # common code formatter
        marksman # language server for markdown
        glow # markdown previewer

        #-- Optional Requirements:
        gdu # disk usage analyzer, required by AstroNvim
        ripgrep # fast search tool, required by AstroNvim's '<leader>fw'(<leader> is space key)
      ];
  };
}
