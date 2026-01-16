{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
in 
{
  config = lib.mkIf (desktop.type == "gnome") {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.displayManager.autoLogin = {
      enable = true;
      user = "${config.devlive.user.name}";
    };
    environment.gnome.excludePackages = (with pkgs; [
      decibels
      evince
      geary
      gnome-console
      gnome-music
      totem
    ]);

    environment.systemPackages = with pkgs; [
      adwaita-qt
      adwaita-qt6
      gnome-decoder
      gnome-obfuscate
      gnome-software
      iotas
      papers
      nixos-artwork.wallpapers.simple-blue
      ghostty
      showtime
    ] ++desktop.gnome.extraPackages;
    programs.evolution.enable = true;

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.gnome.Papers.desktop";
        "text/plain" = "org.gnome.TextEditor.desktop";
      };
    };
  };
}
