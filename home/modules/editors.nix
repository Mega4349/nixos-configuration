{ pkgs, inputs, ... }:

{
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
		defaultEditor = true;
    options = {
      number = true;
      shiftwidth = 2;
      tabstop = 2;
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
		extraPlugins = with pkgs.vimPlugins; [
    	nvim-window-picker
		];
    plugins = {
      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 10;
          }
          {
            type = "text";
            val = [
            	"  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ "
							"  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ "
							" ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ "
							" ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  "
							" ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ "
							" ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ "
							" ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ "
							"    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    "
							"          ░    ░  ░    ░ ░        ░   ░         ░    "
							"                                 ░                   "
						];
          }
          {
            type = "padding";
            val = 4;
          }
          {
            type = "group";
            val = [
              {
              	shortcut = "SPC n";
                desc = "  New file";
                command = "<CMD>ene <CR>";
              }
              {
                shortcut = "SPC e";
                desc = "  Neo-tree Filetree";
                command = "<CMD>Neotree toggle<CR>";
              }
              {
                shortcut = "SPC q";
                desc = "󰗼  Quit Neovim";
                command = ":qa<CR>";
              }
            ];
          }
        ];
      };
			auto-save.enable = true;
			notify.enable = true;
			telescope.enable = true;
			toggleterm.enable = true;
			treesitter.enable = true;
			nvim-autopairs.enable = true;
      indent-blankline = {
        enable = true;
				indent.char = "▏";
				#scope.enabled = false;
      };
      lsp = {
				enable = true;
				servers = {
          rust-analyzer = {
						enable = true;
						installRustc = true;
						installCargo = true;
					};
          pylsp.enable = true;
          nixd.enable = true;
          clangd.enable = true;
          html.enable = true;
          jsonls.enable = true;
          lua-ls.enable = true;
          zls.enable = true;
          cssls.enable = true;
          cmake.enable = true;
          bashls.enable = true; 
        };
			};
      neo-tree = {
        enable = true; 
        filesystem.filteredItems = {
          hideDotfiles = false;
          hideGitignored = false;
        };
        window.width = 28;
				closeIfLastWindow = true;
      };
      lualine = {
        enable = true;
      };
      presence-nvim = {
        enable = true;
      };
			nvim-cmp.enable = true;
			cmp-nvim-lsp.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-omni.enable = true;
      cmp-pandoc-nvim.enable = true;
      cmp-pandoc-references.enable = true;
      cmp-path.enable = true;
      cmp-rg.enable = true;
      cmp-snippy.enable = true;
      cmp-spell.enable = true;
      cmp-tabnine.enable = true;
      cmp-tmux.enable = true;
      cmp-treesitter.enable = true;

      cmp-vim-lsp.enable = true;
      cmp-vimwiki-tags.enable = true;
      cmp-vsnip.enable = true;
      cmp-zsh.enable = true;
			nvim-cmp.snippet.expand = "luasnip";
      nvim-cmp.mappingPresets = ["insert"];
      nvim-cmp.sources = [
	    {name = "nvim_lsp";}
	    {name = "luasnip"; }
        {name = "buffer"; }
        {name = "path"; }
      ];
      nvim-cmp.mapping = {
        "<Tab>" = "cmp.mapping.confirm({ select = true })";
      };
			markdown-preview.enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
      }
			{
				mode = "n";
				key = "<leader>t";
				action = "<cmd>ToggleTerm<cr>";
			}
    ];
		extraConfigLua = ''
			require 'window-picker'.setup({
    		hint = 'floating-big-letter',
    		selection_chars = 'FJDKSLA;CMRUEIWOQP',
    		picker_config = {
        	statusline_winbar_picker = {
            selection_display = function(char, windowid)
              return '%=' .. char .. '%='
            end,
            use_winbar = 'never', -- "always" | "never" | "smart"
        	},
        	floating_big_letter = {
            font = 'ansi-shadow', -- ansi-shadow |
        	},
    		},
    		show_prompt = true,
    		prompt_message = 'Pick window: ',
    		filter_func = nil,
    		filter_rules = {
        	autoselect_one = true,
        	include_current_win = false,
        	bo = {
            filetype = { 'notify' },
            buftype = { 'terminal' },
        	},
        	wo = {},
        	file_path_contains = {},
        	file_name_contains = {},
    		},
			})
				
			function focus_window()
    		local window = require('window-picker').pick_window()
    		vim.api.nvim_set_current_win(window)
			end

			vim.keymap.set('n', '<leader><leader>s', focus_window)
		'';
    extraConfigVim = ''
      highlight NeoTreeNormal guibg=none
      highlight NeoTreeNormal ctermbg=none
      highlight NeoTreeNormalNC guibg=none
      highlight NeoTreeNormalNC ctermbg=none
    '';
    enableMan = false;
  };

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
