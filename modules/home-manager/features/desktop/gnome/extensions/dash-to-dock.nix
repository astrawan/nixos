{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
in
{
  config = lib.mkIf (desktop.type == "gnome") {
    home.packages = with pkgs; [
      gnomeExtensions.dash-to-dock
    ];

    home.file.".local/share/icons/Adwaita/symbolic/actions/view-app-grid-symbolic.svg".source = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";

    dconf.settings."org/gnome/shell/extensions/dash-to-dock" = {
      background-color = "rgb(0,0,0)";
      custom-background-color = true;
      customize-alphas = true;
      disable-overview-on-startup = true;
      dock-fixed = true;
      dock-posistion = "RIGHT";
      extend-height = true;
      hot-keys = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      max-alpha = 1.0;
      min-alpha = 0.0;
      require-pressure-to-show = true;
      transparency-mode = "DYNAMIC";
    };
  };
}
