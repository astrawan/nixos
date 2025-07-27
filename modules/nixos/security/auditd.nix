{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.security.auditd;
in 
{
  config = lib.mkIf cfg.enable {
    security.auditd.enable = true;
    security.audit = {
      enable = true;
      rules = [];
    };
  };
}
