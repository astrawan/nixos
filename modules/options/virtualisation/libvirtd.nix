{ config, lib, ... }:

let
  cfg = config.devlive.virtualisation.libvirtd;
in
{
  options.devlive.virtualisation.libvirtd = {
    enable = lib.mkEnableOption "libvirtd";
  };
}

