{
  inputs,
  lib,
}: let
  typesDag = import ./dag.nix {inherit lib;};
  typesPlugin = import ./plugins.nix {inherit inputs lib;};
  typesLanguage = import ./languages.nix {inherit lib;};
in {
  inherit (typesDag) dagOf;
  inherit (typesPlugin) pluginsOpt extraPluginType;
  inherit (typesLanguage) diagnostics mkGrammarOption;
}
