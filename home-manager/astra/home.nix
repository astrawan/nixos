# vi: sw=2 ts=2 et
{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "astra";
  home.homeDirectory = "/home/astra";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    aegisub
    boxbuddy
    dconf-editor
    distrobox
    dive
    fragments
    gimp
    gnome-extension-manager
    gnome-tweaks
    inkscape
    libreoffice
    nerd-fonts.fira-code
    popcorntime
    remmina
    tcpdump
    vlc
    wireshark
    wl-clipboard
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/background" = {
      picture-uri = "/run/current-system/sw/share/backgrounds/nixos/nix-wallpaper-simple-blue.png";
      picture-uri-dark = "/run/current-system/sw/share/backgrounds/nixos/nix-wallpaper-simple-blue.png";
    };
    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "rgba";
      font-hinting = "medium";
      monospace-font-name = "FiraCode Nerd Font Mono Medium 11";
      show-battery-percentage = true;
    };
    settings."org/gnome/desktop/session" = {
      # 15 minutes
      idle-delay = 900;
    };
    settings."org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];

      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
    };
    settings."org/gnome/desktop/wm/preferences" = {
      num-workspaces = 4;
    };
    settings."org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    # Add custom shortcuts
    settings."org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>e";
      command = "nautilus -w";
      name = "Run File Manager";
    };
    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>q";
      command = "ptyxis --new-window";
      name = "Run Terminal";
    };

    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        logo-menu.extensionUuid
        tailscale-qs.extensionUuid
        tiling-shell.extensionUuid
      ];
      favorite-apps = [
        "org.gnome.Software.desktop"
        "org.gnome.Epiphany.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Ptyxis.desktop"
      ];
    };
    settings."org/gnome/shell/keybindings" = {
      # Remove the default hotkeys for opening favorited applications.
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
    };
    settings."org/gnome/shell/extensions/Logo-menu" = {
      # Use right click to open Activities.
      menu-button-icon-click-type = 3;

      # Use the NixOS logo.
      menu-button-icon-image = 23;

      menu-button-terminal = "ptyxis --new-window";
    };
    settings."org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-battery-timeout = 1800;
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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
    ".config/systemd/user/usbguard-notifier.service".source = "${pkgs.usbguard-notifier}/share/systemd/user/usbguard-notifier.service";
    ".config/systemd/user/default.target.wants/usbguard-notifier.service".source = "${pkgs.usbguard-notifier}/share/systemd/user/usbguard-notifier.service";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/astra/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
    QT_STYLE_OVERRIDE = "Adwaita-dark";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      eval $(starship init bash)
    '';
    sessionVariables = {
      EDITOR = "vim";
    };
  };
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.git = {
    enable = true;
    userEmail = "astra@pm.me";
    userName = "Astrawan Wayan";
    extraConfig = {
      commit = {
        gpgsign = true;
      };
      tag = {
        forceSignAnnotated = true;
      };
      user = {
        signingkey = "A6113EB4F50442EA";
      };
    };
  };
  programs.lazygit.enable = true;
  programs.neovide = {
    enable = true;
    settings = {
      font = {
        size = 12;
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Medium";
        };
      };
    };
  };
  programs.neovim.enable = true;
  programs.ripgrep.enable = true;
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "balitekno.admin.vpn.devlive.cloud" = {
        hostname = "balitekno.admin.vpn.devlive.cloud";
        port = 22;
        user = "astra";
        identityFile = "~/.private/id_ed25519_rhel";
      };
      "bitbucket.stack.devlive.cloud" = {
        hostname = "bitbucket.stack.devlive.cloud";
        port = 22;
        user = "git";
        identityFile = "~/.private/id_ed25519_bitbucket_ts";
      };
      "firewall.admin.vpn.devlive.cloud" = {
        hostname = "firewall.admin.vpn.devlive.cloud";
        port = 2222;
        user = "puffy";
        identityFile = "~/.private/id_ed25519_rhel";
      };
      "gitlab.com" = {
        hostname = "gitlab.com";
        port = 22;
        user = "astrawan";
        identityFile = "~/.private/id_gitlab_new";
      };
      "github.com" = {
        hostname = "github.com";
        port = 22;
        user = "git";
        identityFile = "~/.private/id_ed25519_bitbucket_ts";
      };
    };
  };
  programs.starship.enable = true;
  programs.tmux = {
    customPaneNavigationAndResize = true;
    enable = true;
    escapeTime = 10;
    focusEvents = true;
    historyLimit = 999999;
    keyMode = "vi";
    mouse = false;
  };
  programs.vscode.enable = true;

  services.opensnitch-ui.enable = true;
}
