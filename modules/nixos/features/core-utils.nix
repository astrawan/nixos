{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.core-utils;
in 
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      efibootmgr
      file
      vim
    ];
  };
}
