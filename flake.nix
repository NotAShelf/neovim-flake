{
  description = "A neovim flake with a modular configuration";
  outputs = {
    nixpkgs,
    flake-parts,
    self,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        # add lib to module args
        {_module.args = {inherit (nixpkgs) lib;};}
        ./flake/apps.nix
        ./flake/legacyPackages.nix
        ./flake/overlays.nix
        ./flake/packages.nix
      ];

      flake = {
        lib = {
          inherit (import ./lib/stdlib-extended.nix input:s nixpkgs.lib) nvim;
          inherit (import ./configuration.nix inputs) neovimConfiguration;
        };

        homeManagerModules = {
          neovim-flake = {
            imports = [
              (import ./lib/module self.packages inputs)
            ];
          };

          default = self.homeManagerModules.neovim-flake;
        };
      };

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devShells.default = pkgs.mkShell {nativeBuildInputs = [config.packages.nix];};
        formatter = pkgs.alejandra;
      };
    };

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";

    # For generating documentation website
    nmd = {
      url = "sourcehut:~rycee/nmd";
      flake = false;
    };

    # Langauge server (use master instead of nixpkgs)
    rnix-lsp.url = "github:nix-community/rnix-lsp";

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Tidal cycles
    tidalcycles = {
      url = "github:mitchmindtree/tidalcycles.nix";
      inputs.vim-tidal-src.url = "github:tidalcycles/vim-tidal";
    };

    ## Plugins (must begin with plugin-)

    # LSP plugins
    plugin-nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };

    plugin-lspsaga = {
      url = "github:tami5/lspsaga.nvim";
      flake = false;
    };

    plugin-lspkind = {
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };

    plugin-trouble = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };

    plugin-nvim-treesitter-context = {
      url = "github:nvim-treesitter/nvim-treesitter-context";
      flake = false;
    };

    plugin-nvim-lightbulb = {
      url = "github:kosayoda/nvim-lightbulb";
      flake = false;
    };

    plugin-nvim-code-action-menu = {
      url = "github:weilbith/nvim-code-action-menu";
      flake = false;
    };

    plugin-lsp-signature = {
      url = "github:ray-x/lsp_signature.nvim";
      flake = false;
    };

    plugin-null-ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };

    plugin-sqls-nvim = {
      url = "github:nanotee/sqls.nvim";
      flake = false;
    };

    plugin-rust-tools = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };

    plugin-flutter-tools = {
      url = "github:akinsho/flutter-tools.nvim";
      flake = false;
    };

    plugin-elixir-ls = {
      url = "github:elixir-lsp/elixir-ls";
      flake = false;
    };

    plugin-elixir-tools = {
      url = "github:elixir-tools/elixir-tools.nvim";
      flake = false;
    };

    # Copying/Registers
    plugin-registers = {
      url = "github:tversteeg/registers.nvim";
      flake = false;
    };

    plugin-nvim-neoclip = {
      url = "github:AckslD/nvim-neoclip.lua";
      flake = false;
    };

    # Telescope
    plugin-telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };

    # Debuggers
    plugin-nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };

    plugin-nvim-dap-ui = {
      url = "github:rcarriga/nvim-dap-ui";
      flake = false;
    };

    # Filetrees
    plugin-nvim-tree-lua = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };

    # Tablines
    plugin-nvim-bufferline-lua = {
      url = "github:akinsho/nvim-bufferline.lua";
      flake = false;
    };

    # Statuslines
    plugin-lualine = {
      url = "github:hoob3rt/lualine.nvim";
      flake = false;
    };

    # Completions
    plugin-nvim-compe = {
      url = "github:hrsh7th/nvim-compe"; # TODO: deprecate
      flake = false;
    };

    plugin-nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };

    plugin-cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };

    plugin-cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };

    plugin-cmp-vsnip = {
      url = "github:hrsh7th/cmp-vsnip";
      flake = false;
    };

    plugin-cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };

    plugin-cmp-treesitter = {
      url = "github:ray-x/cmp-treesitter";
      flake = false;
    };

    # snippets
    plugin-vim-vsnip = {
      url = "github:hrsh7th/vim-vsnip";
      flake = false;
    };

    # Discord Rich Presence
    plugin-presence-nvim = {
      url = "github:andweeb/presence.nvim";
      flake = false;
    };

    # Autopairs
    plugin-nvim-autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    plugin-nvim-ts-autotag = {
      url = "github:windwp/nvim-ts-autotag";
      flake = false;
    };

    # Commenting
    plugin-comment-nvim = {
      url = "github:numToStr/Comment.nvim";
      flake = false;
    };

    plugin-todo-comments = {
      url = "github:folke/todo-comments.nvim";
      flake = false;
    };

    # Buffer tools
    plugin-bufdelete-nvim = {
      url = "github:famiu/bufdelete.nvim";
      flake = false;
    };

    # Dashboard Utilities
    plugin-dashboard-nvim = {
      url = "github:glepnir/dashboard-nvim";
      flake = false;
    };

    plugin-alpha-nvim = {
      url = "github:goolord/alpha-nvim";
      flake = false;
    };

    plugin-vim-startify = {
      url = "github:mhinz/vim-startify";
      flake = false;
    };

    # Themes
    plugin-tokyonight = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };

    plugin-onedark = {
      url = "github:navarasu/onedark.nvim";
      flake = false;
    };

    plugin-catppuccin = {
      url = "github:catppuccin/nvim";
      flake = false;
    };

    plugin-dracula = {
      url = "github:Mofiqul/dracula.nvim";
      flake = false;
    };

    # Rust crates
    plugin-crates-nvim = {
      url = "github:Saecki/crates.nvim";
      flake = false;
    };

    # Project Management
    plugin-project-nvim = {
      url = "github:ahmedkhalf/project.nvim";
      flake = false;
    };

    # Visuals
    plugin-nvim-cursorline = {
      url = "github:yamatsum/nvim-cursorline";
      flake = false;
    };

    plugin-scrollbar-nvim = {
      url = "github:petertriho/nvim-scrollbar";
      flake = false;
    };

    plugin-cinnamon-nvim = {
      url = "github:declancm/cinnamon.nvim";
      flake = false;
    };

    plugin-cellular-automaton = {
      url = "github:Eandrju/cellular-automaton.nvim";
      flake = false;
    };

    plugin-indent-blankline = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };

    plugin-nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };

    plugin-gitsigns-nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };

    plugin-fidget-nvim = {
      url = "github:j-hui/fidget.nvim?ref=legacy";
      flake = false;
    };

    # Markdown
    plugin-glow-nvim = {
      url = "github:ellisonleao/glow.nvim";
      flake = false;
    };

    # Minimap
    plugin-minimap-vim = {
      url = "github:wfxr/minimap.vim";
      flake = false;
    };

    plugin-codewindow-nvim = {
      url = "github:gorbit99/codewindow.nvim";
      flake = false;
    };

    # Notifications
    plugin-nvim-notify = {
      url = "github:rcarriga/nvim-notify";
      flake = false;
    };

    # Utilities
    plugin-ccc = {
      url = "github:uga-rosa/ccc.nvim";
      flake = false;
    };

    plugin-diffview-nvim = {
      url = "github:sindrets/diffview.nvim";
      flake = false;
    };

    plugin-icon-picker-nvim = {
      url = "github:ziontee113/icon-picker.nvim";
      flake = false;
    };

    plugin-which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };

    plugin-cheatsheet-nvim = {
      url = "github:sudormrfbin/cheatsheet.nvim";
      flake = false;
    };

    plugin-gesture-nvim = {
      url = "github:notomo/gesture.nvim";
      flake = false;
    };

    plugin-hop-nvim = {
      url = "github:phaazon/hop.nvim";
      flake = false;
    };

    plugin-leap-nvim = {
      url = "github:ggandor/leap.nvim";
      flake = false;
    };

    plugin-smartcolumn = {
      url = "github:m4xshen/smartcolumn.nvim";
      flake = false;
    };

    plugin-nvim-surround = {
      url = "github:kylechui/nvim-surround";
      flake = false;
    };

    # Note-taking
    plugin-obsidian-nvim = {
      url = "github:epwalsh/obsidian.nvim";
      flake = false;
    };

    plugin-orgmode-nvim = {
      url = "github:nvim-orgmode/orgmode";
      flake = false;
    };

    plugin-mind-nvim = {
      url = "github:phaazon/mind.nvim";
      flake = false;
    };

    # Terminal
    plugin-toggleterm-nvim = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };

    # UI
    plugin-nvim-navbuddy = {
      url = "github:SmiteshP/nvim-navbuddy";
      flake = false;
    };

    plugin-nvim-navic = {
      url = "github:SmiteshP/nvim-navic";
      flake = false;
    };

    plugin-noice-nvim = {
      url = "github:folke/noice.nvim";
      flake = false;
    };

    plugin-modes-nvim = {
      url = "github:mvllow/modes.nvim";
      flake = false;
    };

    plugin-nvim-colorizer-lua = {
      url = "github:norcalli/nvim-colorizer.lua";
      flake = false;
    };

    plugin-vim-illuminate = {
      url = "github:RRethy/vim-illuminate";
      flake = false;
    };

    # Assistant
    plugin-copilot-lua = {
      url = "github:zbirenbaum/copilot.lua";
      flake = false;
    };

    plugin-copilot-cmp = {
      url = "github:zbirenbaum/copilot-cmp";
      flake = false;
    };

    # Session management
    plugin-nvim-session-manager = {
      url = "github:Shatur/neovim-session-manager";
      flake = false;
    };

    # Dependencies
    plugin-plenary-nvim = {
      # (required by crates-nvim)
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };

    plugin-dressing-nvim = {
      # (required by icon-picker-nvim)
      url = "github:stevearc/dressing.nvim";
      flake = false;
    };

    plugin-vim-markdown = {
      # (required by obsidian-nvim)
      url = "github:preservim/vim-markdown";
      flake = false;
    };

    plugin-tabular = {
      # (required by vim-markdown)
      url = "github:godlygeek/tabular";
      flake = false;
    };

    plugin-nui-nvim = {
      # (required by noice.nvim)
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };

    plugin-vim-repeat = {
      url = "github:tpope/vim-repeat";
      flake = false;
    };
  };
}
