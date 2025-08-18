# vi: sw=2 ts=2 et
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.initrd.luks.devices."luks-cd64b8dc-54f2-4d38-b7b4-e1d83c5e18e9".device = "/dev/disk/by-uuid/cd64b8dc-54f2-4d38-b7b4-e1d83c5e18e9";

  networking.hostName = "pandorabox";

  # Set your time zone.
  time.timeZone = "${config.devlive.host.timeZone}";

  # Select internationalisation properties.
  i18n.defaultLocale = "${config.devlive.host.defaultLocale}";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.cron.enable = true;
  services.fwupd.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
