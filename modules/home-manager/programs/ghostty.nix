{ config, lib, ... }:

let
  cfg = config.devlive.programs.ghostty;
in
{
  config = lib.mkIf cfg.enable {
    programs.ghostty.enable = true;
    programs.ghostty.settings = {
      font-family = "FiraCode Nerd Font Mono";
      font-style = "SemiBold";
      font-size = 12;
      term = "xterm-256color";
      window-padding-x = 8;
    };
  };
}
