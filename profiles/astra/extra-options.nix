{ config, ... }:

{
  devlive.features.desktop.gnome.enable = true;
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
