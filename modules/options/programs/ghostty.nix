{ config, lib, ... }:

let
  cfg = config.devlive.programs.ghostty;
in
{
  options.devlive.programs.ghostty = {
    enable = lib.mkEnableOption "ghostty";
  };
}
