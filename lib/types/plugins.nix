{lib}:
with lib; let
  fromInputs = inputs: prefix:
    mapAttrs'
    (n: v: nameValuePair (removePrefix prefix n) {src = v;})
    (filterAttrs (n: _: hasPrefix prefix n) inputs);

  rawPlugins = fromInputs inputs "plugin-";

  pluginType = with types;
    nullOr (
      either
      package
      (enum rawPlugins)
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
