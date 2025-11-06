{ config, lib, ... }:

let
  cfg = config.devlive.services.tailscale;
in 
{
  config = lib.mkIf cfg.enable {
    services.tailscale = {
      disableTaildrop = true;
      enable = true;
      extraSetFlags = [
        "--operator"
        "${config.devlive.user.name}"
      ];
      useRoutingFeatures = "both";
    };
  };
}
