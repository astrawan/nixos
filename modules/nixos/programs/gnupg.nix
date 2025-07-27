{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.gnupg;
in 
{
  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
