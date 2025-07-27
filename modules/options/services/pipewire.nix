{ config, lib, ... }:

let
  cfg = config.devlive.services.pipewire;
in 
{
  options.devlive.services.pipewire = {
    enable = lib.mkEnableOption "pipewire";
  };
}
