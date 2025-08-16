{ config, lib, ... }:

let
  cfg = config.devlive.virtualisation.waydroid;
in
{
  config = lib.mkIf cfg.enable {
    virtualisation = {
      waydroid.enable = true;
    };
  };
}
