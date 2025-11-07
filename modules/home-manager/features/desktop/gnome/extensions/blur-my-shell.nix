{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.gnome;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gnomeExtensions.blur-my-shell
    ];

    dconf.settings."org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      static-blur = true;
    };
    dconf.settings."org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = false;
      override-background-dynamically = true;
      static-blur = true;
    };
  };
}
