{ config, lib, pkgs, ... }:

let 
  cfg = config.devlive.features.devel-utils;
in
{
  options.devlive.features.devel-utils = {
    enable = lib.mkEnableOption "devel-utils";
  };
}
