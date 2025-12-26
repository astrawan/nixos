{ config, lib, pkgs, ... }:

{
  imports = [
    ./appindicator.nix
    ./blur-my-shell.nix
    ./dash-to-dock.nix
    ./gsconnect.nix
    ./tailscale-qs.nix
    ./tiling-shell.nix
  ];

  config = lib.mkIf config.devlive.features.desktop.gnome.enable {
    dconf.settings."org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        blur-my-shell.extensionUuid
        dash-to-dock.extensionUuid
        gsconnect.extensionUuid
        tailscale-qs.extensionUuid
        tiling-shell.extensionUuid
      ];
    };
  };
}
