{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.noctalia-shell;
  sddm-noctalia = (pkgs.callPackage ../../../../pkgs/sddm-noctalia.nix {});
in
{
  config = lib.mkIf cfg.enable {
    environment.variables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORMTHEME="qt6ct";
    };
    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
        nerd-fonts.fira-code
      ];
    };
    programs.evolution.enable = true;
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
      extraPackages = [
        sddm-noctalia
      ];
      package = pkgs.kdePackages.sddm;
      settings = {
        Autologin = {
          Session = "hyprland.desktop";
        };
        General = {
          DefaultSession = "hyprland.desktop";
          DisplayServer = "wayland";
        };
        Theme = {
          ThemeDir = "${sddm-noctalia}/share/sddm/themes";
        };
      };
      theme = "noctalia";
      wayland.enable = true;
    };
    services.gvfs.enable = true;
    services.power-profiles-daemon.enable = true;

    # enable usb auto-mount
    services.udisks2.enable = true;

    services.upower.enable = true;
  };
}
