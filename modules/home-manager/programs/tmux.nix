{ config, lib, ... }:

let
  cfg = config.devlive.programs.tmux;
in
{
  config = lib.mkIf cfg.enable {
    programs.tmux = {
      customPaneNavigationAndResize = true;
      enable = true;
      escapeTime = 10;
      focusEvents = true;
      historyLimit = 999999;
      keyMode = "vi";
      mouse = false;
    };
  };
}
