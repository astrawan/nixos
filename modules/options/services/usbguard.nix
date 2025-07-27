{ config, lib, ... }:

let
  cfg = config.devlive.services.usbguard;
in
{
  options.devlive.services.usbguard = {
    enable = lib.mkEnableOption "usbguard";
  };
}
