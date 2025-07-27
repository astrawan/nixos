{ config, lib, ... }:

let
  cfg = config.devlive.programs.lazygit;
in 
{
  options.devlive.programs.lazygit = {
    enable = lib.mkEnableOption "lazygit";
  };
}
