{ config, lib, ... }:

let
  cfg = config.devlive.virtualisation.podman;
in 
{
  options.devlive.virtualisation.podman = {
    enable = lib.mkEnableOption "podman";
  };
}
