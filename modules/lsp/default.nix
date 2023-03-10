{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # nvim lsp support
    ./config.nix
    ./module.nix

    # lsp plugins
    ./lspsaga
    ./nvim-code-action-menu
    ./trouble
    ./lsp-signature
    ./lightbulb
  ];
}
