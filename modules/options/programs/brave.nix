{ config, lib, ... }:

let
  cfg = config.devlive.programs.brave;
in
{
  options.devlive.programs.brave = {
    enable = lib.mkEnableOption "brave";
  };
}
