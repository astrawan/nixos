{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
in
{
  config = lib.mkIf (desktop.type == "gnome") (lib.mkMerge [
    (lib.mkIf config.devlive.services.tailscale.enable {
      home.packages = with pkgs; [
        gnomeExtensions.tailscale-qs
      ];
    })
  ]);
}
