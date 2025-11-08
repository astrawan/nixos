{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.yubikey;
in
{
  options.devlive.features.yubikey = {
    enable = lib.mkEnableOption "yubikey";
  };
}
