{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.core-utils;
in 
{
  options.devlive.features.core-utils = {
    enable = lib.mkEnableOption "core-utils";
  };
}
