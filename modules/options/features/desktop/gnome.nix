{ config, lib, ... }:

let
  cfg = config.devlive.features.desktop.gnome;
in 
{
  options.devlive.features.desktop.gnome = {
    enable = lib.mkEnableOption "gnome";
  };
}
