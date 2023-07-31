{
  inputs,
  lib,
}:
with lib; let
  fromInputs = inputs: prefix:
    mapAttrs'
    (n: v: nameValuePair (removePrefix prefix n) {src = v;})
    (filterAttrs (n: _: hasPrefix prefix n) inputs);

  rawPlugins = fromInputs inputs "plugin-";

  # Define the helper function to extract the names from the name-value pairs
  getNames = list: mapAttrsToList (name: _: name) list;

  # Map all plugin names to a list for pluginType to select from
  mappedPluginList = getNames rawPlugins;

  # Append plugins that are not in the mappedPluginList to the plugin list

  finalPluginList = mappedPluginList ++ ["nvim-treesitter" "flutter-tools-patched"];

  # either a package from nixpkgs, or a plugin from inputs ( + "nvim-treesitter")
  pluginType = with types;
    nullOr (
      either
      package
      (enum finalPluginList)
    );

  pluginsType = types.listOf pluginType;

  extraPluginType = with types;
    submodule {
      options = {
        package = mkOption {
          type = pluginType;
        };
        after = mkOption {
          type = listOf str;
          default = [];
          description = "Setup this plugin after the following ones.";
        };
        setup = mkOption {
          type = lines;
          default = "";
          description = "Lua code to run during setup.";
          example = "require('aerial').setup {}";
        };
      };
    };
in {
  inherit extraPluginType;

  pluginsOpt = {
    description,
    default ? [],
  }:
    mkOption {
      inherit description default;
      type = pluginsType;
    };
}
