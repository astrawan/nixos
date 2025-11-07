{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.gnome;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gnomeExtensions.dash-to-dock
    ];

    dconf.settings."org/gnome/shell/extensions/dash-to-dock" = {
      background-color = "rgb(0,0,0)";
      custom-background-color = true;
      customize-alphas = true;
      disable-overview-on-startup = true;
      dock-fixed = true;
      dock-posistion = "BOTTOM";
      extend-height = false;
      hot-keys = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      max-alpha = 1.0;
      min-alpha = 0.2;
      require-pressure-to-show = true;
      transparency-mode = "DYNAMIC";
    };
  };
}
