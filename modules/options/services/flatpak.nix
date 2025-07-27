{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.services.flatpak;
in 
{
  options.devlive.services.flatpak = {
    enable = lib.mkEnableOption "flatpak";
  };
}
