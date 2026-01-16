{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
in
{
  config = lib.mkIf (desktop.type == "gnome") {
    home.packages = with pkgs; [
      gnomeExtensions.blur-my-shell
    ];

    dconf.settings."org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      static-blur = true;
      # pipeline_default | pipeline_default_rounded
      pipeline = "pipeline_default";
    };
    dconf.settings."org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = false;
      override-background-dynamically = true;
      static-blur = true;
    };
  };
}
