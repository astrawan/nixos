{ config, lib, ... }:

let
  cfg = config.devlive.programs.lazygit;
in 
{
  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        git.overrideGpg = true;
        gui.theme = {
          lightTheme = false;
        };
      };
    };
  };
}
