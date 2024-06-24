{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.nvim.binds) mkBinding pushDownDefault;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.nvim.dag) entryAnywhere;

  cfg = config.vim.tabline.cokeline;

  self = import ./cokeline.nix {inherit lib;};
  inherit (self.options.vim.tabline.cokeline) mappings;
in {
  config = mkIf cfg.enable {
    vim = {
      startPlugins = [
        (assert config.vim.visuals.nvimWebDevicons.enable; "nvim-cokeline")
        "bufdelete-nvim"
      ];

      maps.normal = mkMerge [
        (mkBinding cfg.mappings.cycleNext "<Plug>(cokeline-focus-next)" mappings.cycleNext.description)
        (mkBinding cfg.mappings.cyclePrevious "<Plug>(cokeline-focus-prev)" mappings.cyclePrevious.description)
        (mkBinding cfg.mappings.switchNext "<Plug>(cokeline-switch-next)" mappings.switchNext.description)
        (mkBinding cfg.mappings.switchPrevious "<Plug>(cokeline-switch-prev)" mappings.switchPrevious.description)
        # this does not work
        # (mkBinding cfg.mappings.pick "<Plug>(cokeline-pick-focus)" mappings.pick.description)
        # (mkLuaBinding cfg.mappings.pick "function() require('cokeline.mappings').pick(\"focus\") end" mappings.pick.description)
        # (mkBinding cfg.mappings.closeByLetter "<Plug>(cokeline-pick-close)" mappings.closeByLetter.description)
      ];

      binds.whichKey.register = pushDownDefault {
        "<leader>b" = "+Buffer";
        "<leader>bm" = "BufferLineMove";
      };

      luaConfigRC = {
        cokeline = entryAnywhere ''
          require('cokeline').setup(${toLuaObject cfg.setupOpts})
        '';
      };
    };
  };
}
