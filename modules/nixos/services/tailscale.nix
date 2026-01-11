{ config, lib, ... }:

let
  cfg = config.devlive.services.tailscale;
in 
{
  config = lib.mkIf cfg.enable {
    services.tailscale = {
      disableTaildrop = false;
      enable = true;
      extraSetFlags = [
        "--operator"
        "${config.devlive.user.name}"
        "--shields-up"
      ];
      useRoutingFeatures = "both";
    };
  };
}
