{ config, lib, ... }:

let
  cfg = config.devlive.services.openssh;
in 
{
  config = lib.mkIf cfg.enable {
    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      openFirewall = false;
    };
  };
}
