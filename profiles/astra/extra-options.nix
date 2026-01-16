{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
in
{
  devlive.features.desktop = {
    type = "noctalia";
    extraHomePackages = with pkgs; [
        aegisub
        freerdp
        gimp
        gradia
        inkscape
        libreoffice
        nerd-fonts.fira-code
        popcorntime
        telegram-desktop
        wireshark
    ];
    gnome.extraHomePackages = lib.mkIf (desktop.type == "gnome") (with pkgs; [
        dconf-editor
        foliate
        fragments
        gnome-extension-manager
        gnome-tweaks
        lock
    ]);
    noctalia = lib.mkIf (desktop.type == "noctalia") {
      compositor = "hyprland";
      extraHomePackages = (
        if desktop.noctalia.compositor == "hyprland"
        then
          (with pkgs; [
            qbittorrent
          ])
        else (with pkgs; [
            fragments
          ])
      );
    };
  };
  devlive.features.devel-android.enable = true;
  devlive.features.yubikey.enable = true;

  devlive.programs.bash.enable = true;
  devlive.programs.brave.enable = true;
  devlive.programs.deja-dup = {
    enable = true;
    include-list = ["/home/${config.devlive.user.name}/Documents/Synchronizable"];
    google = {
      enable = true;
    };
    periodic = true;
  };
  devlive.programs.keystore-explorer.enable = true;
  devlive.programs.vaults = {
    enable = true;
    settings = {
      encrypted_data_directory = "/home/${config.devlive.user.name}/Documents/Synchronizable/Vaults";
    };
  };
  devlive.programs.zen-browser.enable = true;

  devlive.security.auditd.enable = true;

  devlive.services.flatpak.enable = true;
  devlive.services.opensnitch.enable = true;
  devlive.services.openssh.enable = false;
  devlive.services.pipewire.enable = true;
  devlive.services.tailscale.enable = true;
  devlive.services.usbguard.enable = true;

  devlive.virtualisation.libvirtd.enable = true;
  devlive.virtualisation.waydroid.enable = true;
}
