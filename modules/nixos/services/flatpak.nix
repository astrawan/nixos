{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.services.flatpak;
in 
{
  config = lib.mkIf cfg.enable {
    # Enable flatpak
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}

