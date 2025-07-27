{ config, lib, ... }:

let
  cfg = config.devlive.services.tailscale;
in 
{
  options.devlive.services.tailscale = {
    enable = lib.mkEnableOption "tailscale";
  };
}
