{ config, pkgs, ... }:

{
  imports = [
    ../../modules/options
  ];

  devlive.host = {
    timeZone = "Asia/Makassar";
    defaultLocale = "en_US.UTF-8";
  };

  devlive.user = {
    name = "astra";
    fullName = "Astrawan Wayan";
    groups = [ "networkmanager" "wheel" ];
    email = "astra@pm.me";
    packages = with pkgs; [
      home-manager
    ];
  };

  devlive.features.core-utils.enable = true;
  devlive.features.devel-utils.enable = true;
  devlive.features.desktop.gnome.enable = true;

  devlive.programs.bash.enable = true;
  devlive.programs.deja-dup = {
    enable = true;
    include-list = ["/home/${config.devlive.user.name}/Documents/Synchronizable"];
    google = {
      enable = true;
    };
    periodic = true;
  };
  devlive.programs.folio = {
    enable = true;
    enable-autosave = true;
    note-font-monospace = "FiraCode Nerd Font Mono Medium 10";
    notes-dir = "/home/${config.devlive.user.name}/Documents/Synchronizable/Folio/Notes";
    trash-dir = "/home/${config.devlive.user.name}/Documents/Synchronizable/Folio/Trash";
  };
  devlive.programs.gnupg.enable = true;
  devlive.programs.lazygit.enable = true;
  devlive.programs.tmux.enable = true;

  devlive.security.auditd.enable = true;

  devlive.services.flatpak.enable = true;
  devlive.services.opensnitch.enable = true;
  devlive.services.openssh.enable = true;
  devlive.services.pipewire.enable = true;
  devlive.services.tailscale.enable = true;
  devlive.services.usbguard.enable = true;

  devlive.virtualisation.libvirtd.enable = true;
  devlive.virtualisation.podman.enable = true;
}
