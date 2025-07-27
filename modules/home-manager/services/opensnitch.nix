{ config, lib, ... }:

let
  cfg = config.devlive.services.opensnitch;
in 
{
  config = lib.mkIf cfg.enable {
    services.opensnitch-ui.enable = true;

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

      ".config/opensnitch/settings.conf".text = ''
        [auth]
        cacert=
        cert=
        certkey=
        type=simple

        [database]
        file=file::memory:
        jrnl_wal=false
        max_days=1
        purge_interval=5
        purge_oldest=false
        type=0

        [global]
        default_action=0
        default_duration=6
        default_ignore_rules=false
        default_ignore_temporary_rules=0
        default_popup_advanced=false
        default_popup_advanced_dstip=false
        default_popup_advanced_dstport=false
        default_popup_advanced_uid=false
        default_popup_position=0
        default_target=0
        default_timeout=60
        disable_popups=false
        qt_platform_plugin=
        screen_scale_factor=1
        screen_scale_factor_auto=true
        server_max_message_length=4MiB
        theme=dark_blue.xml
        theme_density_scale=0

        [infoWindow]

        [notifications]
        enabled=true
        type=0

        [promptDialog]

        [statsDialog]
      '';
    };
  };
}
