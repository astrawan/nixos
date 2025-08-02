{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.gnome;
in 
{
  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.excludePackages = [ pkgs.xterm ];

    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.displayManager.autoLogin = {
      enable = true;
      user = "${config.devlive.user.name}";
    };
    environment.gnome.excludePackages = (with pkgs; [
      decibels
      geary
      gnome-console
      gnome-music
      totem
    ]);

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    environment.systemPackages = with pkgs; [
      adwaita-qt
      adwaita-qt6
      gnome-software
      nixos-artwork.wallpapers.simple-blue
      ptyxis
      showtime
    ];

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.gnome.Evince.desktop";
      };
    };
  };
}
