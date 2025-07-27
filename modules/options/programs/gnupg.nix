{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.gnupg;
in 
{
  options.devlive.programs.gnupg = {
    enable = lib.mkEnableOption "gnupg";
  };
}
