{ config, lib, ... }:

let
  cfg = config.devlive.programs.librewolf;
in
{
  options.devlive.programs.librewolf = {
    enable = lib.mkEnableOption "librewolf";
  };
}
