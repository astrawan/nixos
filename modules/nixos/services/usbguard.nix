{ config, lib, ... }:

let
  cfg = config.devlive.services.usbguard;
in
{
  config = lib.mkIf cfg.enable {
    services.usbguard = {
      enable = true;
      IPCAllowedGroups = [ "wheel" ];
    };
  };
}
