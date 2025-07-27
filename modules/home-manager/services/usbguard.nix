{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.services.usbguard;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      usbguard-notifier
    ];
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';

      ".config/systemd/user/usbguard-notifier.service".source = "${pkgs.usbguard-notifier}/share/systemd/user/usbguard-notifier.service";
      ".config/systemd/user/default.target.wants/usbguard-notifier.service".source = "${pkgs.usbguard-notifier}/share/systemd/user/usbguard-notifier.service";
    };
  };
}
