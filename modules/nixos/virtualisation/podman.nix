{ config, lib, ... }:

let
  cfg = config.devlive.virtualisation.podman;
in 
{
  config = lib.mkIf cfg.enable {
    # Enable podman
    virtualisation = {
      containers.enable = true;

      podman = {
        enable = true;

        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;

        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
