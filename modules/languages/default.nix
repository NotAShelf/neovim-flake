{lib, ...}:
with lib; let
  mkEnable = desc:
    mkOption {
      description = "Turn on ${desc} for enabled languages by default";
      type = types.bool;
      default = false;
    };
in {
  imports = [
    ./markdown
    ./tidal
    ./dart
    ./elixir

    ./clang.nix
    ./go.nix
    ./nix.nix
    ./python.nix
    ./ruby.nix
    ./rust.nix
    ./sql.nix
    ./ts.nix
    ./zig.nix
    ./html.nix
    ./svelte.nix
  ];

  options.vim.languages = {
    enableLSP = mkEnable "LSP";
    enableDAP = mkEnable "Debug Adapter";
    enableTreesitter = mkEnable "treesitter";
    enableFormat = mkEnable "formatting";
    enableExtraDiagnostics = mkEnable "extra diagnostics";
  };
}
