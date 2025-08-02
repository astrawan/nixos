{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.virtualisation.podman;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      distrobox
      dive
      podman-compose
    ]
    ++ (
      if config.devlive.features.desktop.gnome.enable then
        with pkgs; [
          boxbuddy
          pods
        ]
      else
        []
    );
  };
}
