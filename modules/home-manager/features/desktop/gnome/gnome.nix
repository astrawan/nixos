{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.gnome;
in 
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dconf-editor
      foliate
      fragments
      gimp
      gnome-extension-manager
      gnome-tweaks
      inkscape
      lock
      nerd-fonts.fira-code
      remmina
    ];

    dconf.enable = true;
    dconf.settings."org/gnome/desktop/background" = {
      picture-uri = "/home/${config.devlive.user.name}/.dotfiles/assets/wallpapers/background-6556413.jpg";
      picture-uri-dark = "/home/${config.devlive.user.name}/.dotfiles/assets/wallpapers/background-6556413.jpg";
    };
    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "rgba";
      font-hinting = "medium";
      monospace-font-name = "FiraCode Nerd Font Mono SemiBold 12";
      show-battery-percentage = true;
    };
    dconf.settings."org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];

      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
    };
    dconf.settings."org/gnome/desktop/wm/preferences" = {
      num-workspaces = 4;
    };
    dconf.settings."org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

      # Add custom shortcuts
    dconf.settings."org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>e";
      command = "nautilus -w";
      name = "Run File Manager";
    };
    dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>q";
      command = "ghostty";
      name = "Run Terminal";
    };

    dconf.settings."org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "org.gnome.Software.desktop"
        "org.gnome.Epiphany.desktop"
        "org.gnome.Evolution.desktop"
        "org.gnome.Nautilus.desktop"
        "com.mitchellh.ghostty.desktop"
      ]
      ++ (
        if config.devlive.programs.folio.enable then
          ["com.toolstack.Folio.desktop"]
        else
          []
      );
      last-selected-power-profile = "power";
    };
    dconf.settings."org/gnome/shell/keybindings" = {
      # Remove the default hotkeys for opening favorited applications.
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
    };
    dconf.settings."org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-battery-timeout = 1800;
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

    home.sessionVariables = {
      QT_STYLE_OVERRIDE = "Adwaita-dark";
    };

    programs.ghostty.enable = true;
    programs.ghostty.settings = {
      font-family = "FiraCode Nerd Font Mono";
      font-style = "SemiBold";
      font-size = 12;
      theme = "Adwaita Dark";
      window-padding-x = 8;
    };
  };
}
