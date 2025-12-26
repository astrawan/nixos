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
      telegram-desktop
      zoom-us
    ];

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";

      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "image/tiff" = "org.gnome.Loupe.desktop";
      "image/x-tga" = "org.gnome.Loupe.desktop";
      "image/vnd-ms.dds" = "org.gnome.Loupe.desktop";
      "image/x-dds" = "org.gnome.Loupe.desktop";
      "image/bmp" = "org.gnome.Loupe.desktop";
      "image/vnd.microsoft.icon" = "org.gnome.Loupe.desktop";
      "image/vnd.radiance" = "org.gnome.Loupe.desktop";
      "image/x-exr" = "org.gnome.Loupe.desktop";
      "image/x-portable-bitmap" = "org.gnome.Loupe.desktop";
      "image/x-portable-graymap" = "org.gnome.Loupe.desktop";
      "image/x-portable-pixmap" = "org.gnome.Loupe.desktop";
      "image/x-portable-anymap" = "org.gnome.Loupe.desktop";
      "image/x-qoi" = "org.gnome.Loupe.desktop";
      "image/qoi" = "org.gnome.Loupe.desktop";
      "image/svg+xml" = "org.gnome.Loupe.desktop";
      "image/svg+xml-compressed" = "org.gnome.Loupe.desktop";
      "image/avif" = "org.gnome.Loupe.desktop";
      "image/heic" = "org.gnome.Loupe.desktop";
      "image/jxl" = "org.gnome.Loupe.desktop";
      "image/g3fax" = "gimp.desktop";
      "image/x-fits" = "gimp.desktop";
      "image/x-pcx" = "gimp.desktop";
      "image/x-psd" = "gimp.desktop";
      "image/x-sgi" = "gimp.desktop";
      "image/x-xbitmap" = "gimp.desktop";
      "image/x-xwindowdump" = "gimp.desktop";
      "image/x-xcf" = "gimp.desktop";
      "image/x-compressed-xcf" = "gimp.desktop";
      "image/x-gimp-gbr" = "gimp.desktop";
      "image/x-gimp-pat" = "gimp.desktop";
      "image/x-gimp-gih" = "gimp.desktop";
      "image/x-sun-raster" = "gimp.desktop";
      "image/x-psp" = "gimp.desktop";
      "image/x-icon" = "gimp.desktop";
      "image/x-xpixmap" = "gimp.desktop";
      "image/x-webp" = "gimp.desktop";
      "image/heif" = "gimp.desktop";
      "image/x-wmf" = "gimp.desktop";
      "image/jp2" = "gimp.desktop";
      "image/x-xcursor" = "gimp.desktop";
    };

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

      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
    };
    dconf.settings."org/gnome/desktop/wm/preferences" = {
      num-workspaces = 3;
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
      ]
      ++ (
        if config.devlive.programs.brave.enable then
          ["brave-browser.desktop"]
        else
          []
      )
      ++ (
        if config.devlive.programs.librewolf.enable then
          ["librewolf.desktop"]
        else
          []
      )
      ++ (
        if config.devlive.programs.zen-browser.enable then
          ["zen-beta.desktop"]
        else
          []
      )
      ++ [
        "org.gnome.Evolution.desktop"
        "org.gnome.Nautilus.desktop"
        "com.mitchellh.ghostty.desktop"
      ]
      ++ (
        if config.devlive.programs.folio.enable then
          ["com.toolstack.Folio.desktop"]
        else
          []
      )
      ++ [
        "org.telegram.desktop.desktop"
      ]
      ++ (
        if config.devlive.features.devel-utils.enable then
          ["dbeaver.desktop"]
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

    devlive.programs.ghostty.enable = true;
    programs.ghostty.settings.theme = "Adwaita Dark";
  };
}
