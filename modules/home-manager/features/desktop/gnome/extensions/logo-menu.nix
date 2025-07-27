{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.gnome;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gnomeExtensions.logo-menu
    ];

    dconf.settings."org/gnome/shell/extensions/Logo-menu" = {
        # Use right click to open Activities.
        menu-button-icon-click-type = 3;

        # Use the NixOS logo.
        menu-button-icon-image = 23;

        menu-button-terminal = "ptyxis --new-window";
    };
  };
}
