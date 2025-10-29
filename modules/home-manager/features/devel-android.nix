{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.devel-android;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = (
      if config.devlive.features.desktop.gnome.enable then
        with pkgs; [genymotion]
      else
        []
    );
  };
}
