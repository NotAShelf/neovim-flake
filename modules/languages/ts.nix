{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.ts;

  defaultServer = "tsserver";
  servers = {
    tsserver = {
      package = pkgs.nodePackages.typescript-language-server;
      lspConfig = ''
        lspconfig.tsserver.setup {
          capabilities = capabilities;
          on_attach = attach_keymaps,
          cmd = { "${cfg.lsp.package}/bin/typescript-language-server", "--stdio" }
        }
      '';
    };
  };

  # TODO: specify packages
  defaultFormat = "prettier";
  formats = {
    prettier = {
      package = pkgs.nodePackages.prettier;
      nullConfig = ''
        table.insert(
          ls_sources,
          null_ls.builtins.formatting.prettier.with({
            command = "${cfg.format.package}/bin/prettier",
          })
        )
      '';
    };
    prettierd = {
      package = pkgs.prettierd;
      nullConfig = ''
        table.insert(
          ls_sources,
          null_ls.builtins.formatting.prettier.with({
            command = "${cfg.format.package}/bin/prettierd",
          })
        )
      '';
    };
  };

  # TODO: specify packages
  defaultDiagnostics = ["eslint_d"];
  diagnostics = {
    eslint_d = {
      package = pkgs.nodePackages.eslint_d;
      nullConfig = pkg: ''
        table.insert(
          ls_sources,
          null_ls.builtins.diagnostics.eslint_d.with({
            command = "${lib.getExe pkg}",
          })
        )
      '';
    };
  };
in {
  options.vim.languages.ts = {
    enable = mkEnableOption "Typescript/Javascript language support";

    treesitter = {
      enable = mkEnableOption "Enable Typescript/Javascript treesitter" // {default = config.vim.languages.enableTreesitter;};
      tsPackage = nvim.types.mkGrammarOption pkgs "tsx";
      jsPackage = nvim.types.mkGrammarOption pkgs "javascript";
    };

    lsp = {
      enable = mkEnableOption "Enable Typescript/Javascript LSP support" // {default = config.vim.languages.enableLSP;};

      server = mkOption {
        description = "Typescript/Javascript LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };

      package = mkOption {
        description = "Typescript/Javascript LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
    };

    format = {
      enable = mkEnableOption "Enable Typescript/Javascript formatting" // {default = config.vim.languages.enableFormat;};

      type = mkOption {
        description = "Typescript/Javascript formatter to use";
        type = with types; enum (attrNames formats);
        default = defaultFormat;
      };

      package = mkOption {
        description = "Typescript/Javascript formatter package";
        type = types.package;
        default = formats.${cfg.format.type}.package;
      };
    };

    extraDiagnostics = {
      enable = mkEnableOption "Enable extra Typescript/Javascript diagnostics" // {default = config.vim.languages.enableExtraDiagnostics;};

      types = lib.nvim.types.diagnostics {
        langDesc = "Typescript/Javascript";
        inherit diagnostics;
        inherit defaultDiagnostics;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.treesitter.enable {
      vim.treesitter.enable = true;
      vim.treesitter.grammars = [cfg.treesitter.tsPackage cfg.treesitter.jsPackage];
    })

    (mkIf cfg.lsp.enable {
      vim.lsp.lspconfig.enable = true;
      vim.lsp.lspconfig.sources.ts-lsp = servers.${cfg.lsp.server}.lspConfig;
    })

    (mkIf cfg.format.enable {
      vim.lsp.null-ls.enable = true;
      vim.lsp.null-ls.sources.ts-format = formats.${cfg.format.type}.nullConfig;
    })

    (mkIf cfg.extraDiagnostics.enable {
      vim.lsp.null-ls.enable = true;
      vim.lsp.null-ls.sources = lib.nvim.languages.diagnosticsToLua {
        lang = "ts";
        config = cfg.extraDiagnostics.types;
        inherit diagnostics;
      };
    })
  ]);
}
