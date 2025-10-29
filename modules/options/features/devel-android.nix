{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.devel-android;
in
{
  options.devlive.features.devel-android = {
    enable = lib.mkEnableOption "devel-android";
  };
}
