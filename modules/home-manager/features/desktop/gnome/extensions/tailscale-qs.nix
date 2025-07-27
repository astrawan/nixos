{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.gnome;
in
{
  config = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf config.devlive.services.tailscale.enable {
      home.packages = with pkgs; [
        gnomeExtensions.tailscale-qs
      ];
    })
  ]);
}
