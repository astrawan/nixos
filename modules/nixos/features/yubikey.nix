{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.yubikey;
in 
{
  config = lib.mkIf cfg.enable {
    services.pcscd = {
      enable = true;
    };
  };
}
