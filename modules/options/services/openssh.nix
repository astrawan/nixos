{ config, lib, ... }:

let
  cfg = config.devlive.services.openssh;
in 
{
  options.devlive.services.openssh = {
    enable = lib.mkEnableOption "openssh";
  };
}
