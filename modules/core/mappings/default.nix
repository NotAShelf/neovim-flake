{lib, ...}: let
  inherit (lib) mkOption types;
  inherit (lib) nvim;
  inherit (nvim.modules) mkBoolOption;

  # Most of the keybindings code is highly inspired by pta2002/nixvim. Thank you!
  mapConfigOptions = {
    silent =
      mkBoolOption false
      "Whether this mapping should be silent. Equivalent to adding <silent> to a map.";

    nowait =
      mkBoolOption false
      "Whether to wait for extra input on ambiguous mappings. Equivalent to adding <nowait> to a map.";

    script =
      mkBoolOption false
      "Equivalent to adding <script> to a map.";

    expr =
      mkBoolOption false
      "Means that the action is actually an expression. Equivalent to adding <expr> to a map.";

    unique =
      mkBoolOption false
      "Whether to fail if the map is already defined. Equivalent to adding <unique> to a map.";

    noremap =
      mkBoolOption true
      "Whether to use the 'noremap' variant of the command, ignoring any custom mappings on the defined action. It is highly advised to keep this on, which is the default.";

    desc = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "A description of this keybind, to be shown in which-key, if you have it enabled.";
    };
  };

  mapOption = types.submodule {
    options =
      mapConfigOptions
      // {
        action = mkOption {
          type = types.str;
          description = "The action to execute.";
        };

        lua = mkOption {
          type = types.bool;
          description = ''
            If true, `action` is considered to be lua code.
            Thus, it will not be wrapped in `""`.
          '';
          default = false;
        };
      };
  };

  mapOptions = mode:
    mkOption {
      description = "Mappings for ${mode} mode";
      type = types.attrsOf mapOption;
      default = {};
    };
in {
  options = {
    vim = {
      maps = mkOption {
        type = types.submodule {
          options = {
            normal = mapOptions "normal";
            insert = mapOptions "insert";
            select = mapOptions "select";
            visual = mapOptions "visual and select";
            terminal = mapOptions "terminal";
            normalVisualOp = mapOptions "normal, visual, select and operator-pending (same as plain 'map')";

            visualOnly = mapOptions "visual only";
            operator = mapOptions "operator-pending";
            insertCommand = mapOptions "insert and command-line";
            lang = mapOptions "insert, command-line and lang-arg";
            command = mapOptions "command-line";
          };
        };
        default = {};
        description = ''
          Custom keybindings for any mode.

          For plain maps (e.g. just 'map' or 'remap') use maps.normalVisualOp.
        '';

        example = ''
          maps = {
            normal."<leader>m" = {
              silent = true;
              action = "<cmd>make<CR>";
            }; # Same as nnoremap <leader>m <silent> <cmd>make<CR>
          };
        '';
      };
    };
  };
}
