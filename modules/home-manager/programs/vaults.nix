{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.vaults;
  settingsFormat = pkgs.formats.toml { };
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vaults
    ];
    home.file.".config/global_config.toml".source = (settingsFormat.generate "global_config.toml" cfg.settings);
  };
}
