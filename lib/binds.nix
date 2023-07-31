{lib}: let
  inherit (lib) types;
in rec {
  mkLuaBinding = key: action: desc:
    lib.mkIf (key != null) {
      "${key}" = {
        inherit action desc;
        lua = true;
        silent = true;
      };
    };

  mkExprBinding = key: action: desc:
    lib.mkIf (key != null) {
      "${key}" = {
        inherit action desc;
        lua = true;
        silent = true;
        expr = true;
      };
    };

  mkBinding = key: action: desc:
    lib.mkIf (key != null) {
      "${key}" = {
        inherit action desc;
        silent = true;
      };
    };

  mkMappingOption = description: default:
    lib.mkOption {
      type = with types; nullOr str;
      inherit default description;
    };

  # Utility function that takes two attrsets:
  # { someKey = "some_value" } and
  # { someKey = { description = "Some Description"; }; }
  # and merges them into
  # { someKey = { value = "some_value"; description = "Some Description"; }; }
  addDescriptionsToMappings = actualMappings: mappingDefinitions:
    lib.attrsets.mapAttrs (name: value: let
      isNested = lib.isAttrs value;
      returnedValue =
        if isNested
        then addDescriptionsToMappings actualMappings."${name}" mappingDefinitions."${name}"
        else {
          value = value;
          description = mappingDefinitions."${name}".description;
        };
    in
      returnedValue)
    actualMappings;

  mkSetBinding = binding: action:
    mkBinding binding.value action binding.description;

  mkSetExprBinding = binding: action:
    mkExprBinding binding.value action binding.description;

  mkSetLuaBinding = binding: action:
    mkLuaBinding binding.value action binding.description;

  # For forward compatibility.
  literalExpression = lib.literalExpression or lib.literalExample;
  literalDocBook = lib.literalDocBook or lib.literalExample;
}
