{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.security.auditd;
in 
{
  options.devlive.security.auditd = {
    enable = lib.mkEnableOption "auditd";
  };
}
