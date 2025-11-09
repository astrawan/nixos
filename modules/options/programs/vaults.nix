{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.vaults;
  settingsFormat = pkgs.formats.toml { };
in
{
  options.devlive.programs.vaults = {
    enable = lib.mkEnableOption "vaults";
    settings = lib.mkOption {
      inherit (settingsFormat) type;
      default = {};
    };
  };
}
