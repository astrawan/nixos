{ config, lib, ... }:

let
  cfg = config.devlive.services.opensnitch;
in 
{
  config = lib.mkIf cfg.enable {
    services.opensnitch.enable = true;
  };
}
