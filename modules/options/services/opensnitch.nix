{ config, lib, ... }:

let
  cfg = config.devlive.services.opensnitch;
in 
{
  options.devlive.services.opensnitch = {
    enable = lib.mkEnableOption "opensnitch";
  };
}
