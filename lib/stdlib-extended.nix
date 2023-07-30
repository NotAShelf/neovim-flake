# From home-manager: https://github.com/nix-community/home-manager/blob/master/modules/lib/stdlib-extended.nix
# Just a convenience function that returns the given Nixpkgs standard
# library extended with the HM library.
nixpkgsLib: inputs: let
  mkNvimLib = import ./.;
in
  nixpkgsLib.extend (self: super: {
    nvim = mkNvimLib {
      inherit inputs;
      lib = self;
    };
  })
