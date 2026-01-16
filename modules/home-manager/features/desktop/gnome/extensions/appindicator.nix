{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
in
{
  config = lib.mkIf (desktop.type == "gnome") {
    home.packages = with pkgs; [
      gnomeExtensions.appindicator
    ];
  };
}
