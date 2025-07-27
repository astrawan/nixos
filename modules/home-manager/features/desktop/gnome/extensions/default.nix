{ config, pkgs, ... }:

{
  imports = [
    ./appindicator.nix
    ./gsconnect.nix
    ./logo-menu.nix
    ./tailscale-qs.nix
    ./tiling-shell.nix
  ];

  dconf.settings."org/gnome/shell" = {
    enabled-extensions = with pkgs.gnomeExtensions; [
      appindicator.extensionUuid
      gsconnect.extensionUuid
      logo-menu.extensionUuid
      tailscale-qs.extensionUuid
      tiling-shell.extensionUuid
    ];
  };
}
