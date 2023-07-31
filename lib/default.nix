{
  inputs,
  lib,
}: {
  dag = import ./dag.nix {inherit lib;};
  booleans = import ./booleans.nix {inherit lib;};
  types = import ./types {inherit lib inputs;};
  languages = import ./languages.nix {inherit lib;};
  nmd = import ./nmd.nix;
  lua = import ./lua.nix {inherit lib;};
  binds = import ./binds.nix {inherit lib;};

  imports = [
    (import ./binds.nix {inherit lib;})
  ];
}
