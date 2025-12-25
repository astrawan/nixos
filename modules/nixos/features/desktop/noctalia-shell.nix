{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.noctalia-shell;
in
{
  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    hardware.bluetooth.enable = true;
    services.displayManager.autoLogin = {
      enable = true;
      user = "${config.devlive.user.name}";
    };
    services.displayManager.sddm = {
      enable = true;
      settings = {
        Autologin = {
          Session = "hyprland.desktop";
        };
        General = {
          DefaultSession = "hyprland.desktop";
          DisplayServer = "wayland";
        };
      };
      wayland.enable = true;
    };
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
  };
}
