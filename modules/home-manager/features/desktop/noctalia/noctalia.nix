{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
  yaziPlugins = {
    gvfs = (pkgs.callPackage ../../../../../pkgs/yazi/plugins/gvfs.nix {});
  };
in
{
  config = lib.mkIf (desktop.type == "noctalia") {
    home.packages = with pkgs; [
      adw-gtk3
      adwaita-icon-theme
      bazaar
      # noctalia gtk4 color schema integration
      glib
      kdePackages.breeze-icons
      kdePackages.qt6ct
      libsForQt5.qt5ct
      networkmanagerapplet
      wayclip
    ] ++desktop.extraHomePackages ++desktop.noctalia.extraHomePackages;
    home.file.".config/qt6ct/qt6ct.conf".text = lib.generators.toINI {} {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "breeze-dark";
      };
      Fonts = {
        fixed = ''"FiraCode Nerd Font Mono Med,11,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
        general = ''"DejaVu Sans,11,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
      };
    };
    home.file.".config/qt5ct/qt5ct.conf".text = lib.generators.toINI {} {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "breeze-dark";
      };
      Fonts = {
        fixed = ''"FiraCode Nerd Font Mono Med,11,-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"DejaVu Sans,11,-1,5,50,0,0,0,0,0,Regular"'';
      };
    };
    devlive.programs.ghostty.enable = true;
    programs.ghostty.settings = {
      # niri doesn't support window blur
      background-opacity = if (desktop.noctalia.compositor == "hyprland") then 0.8 else 1.0;
      theme = "noctalia";
    };
    # System monitor
    programs.bottom.enable = true;
    programs.eza = {
      colors = "always";
      enable = true;
      icons = "always";
    };
    # Image preview
    programs.imv.enable = true;
    # Media player
    programs.mpv.enable = true;
    programs.quickshell.enable = true;
    programs.noctalia-shell = {
      enable = true;
      package = pkgs.noctalia-shell.override { calendarSupport = true; };
      settings = {
        appLauncher = {
          position = "follow_bar";
          terminalCommand = "ghostty -e";
          viewMode = "grid";
        };
        bar = {
          density = "comfortable";
          monitors = [
            "eDP-1"
          ];
          position = "left";
          widgets = {
            center = [
              {
                id = "SystemMonitor";
              }
            ];
            left = [
              {
                icon = "rocket";
                id = "CustomButton";
                leftClickExec = "noctalia-shell ipc call launcher toggle";
              }
              {
                id = "Clock";
                usePrimaryColor = false;
              }
              {
                id = "Workspace";
                hideUnoccupied = false;
              }
            ];
            right = [
              {
                id = "MediaMini";
              }
              {
                id = "Tray";
                pinned = [
                  "nm-applet"
                  "opensnitch-ui"
                  "udiskie"
                ];
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Battery";
              }
              {
                id = "Volume";
              }
              {
                id = "Brightness";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "ControlCenter";
                customIconPath = "${pkgs.nixos-icons}/share/icons/hicolor/24x24/apps/nix-snowflake-white.png";
              }
            ];
          };
        };
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "timer-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };
        colorSchemes.predefinedScheme = "Noctalia (default)";
        general = {
          allowPanelsOnScreenWithoutBar = true;
          compactLockScreen = true;
          enableShadows = false;
          showScreenCorners = true;
          showSessionButtonsOnLockScreen = false;
        };
        location = {
          name = "Kuta, Indonesia";
        };
        notifications = {
          location = "bottom_left";
          monitors = [
            "eDP-1"
          ];
        };
        templates = {
          gtk = true;
          qt = true;
          kcolorscheme = true;
          alacritty = false;
          kitty = false;
          ghostty = true;
          foot = false;
          wezterm = false;
          fuzzel = false;
          discord = false;
          pywalfox = false;
          vicinae = false;
          walker = false;
          code = false;
          spicetify = false;
          telegram = true;
          cava = false;
          yazi = true;
          emacs = false;
          niri = if (desktop.noctalia.compositor == "niri") then true else false;
          hyprland = if (desktop.noctalia.compositor == "hyprland") then true else false;
          mango = false;
          zed = false;
          helix = false;
          enableUserTemplates = false;
        };
        ui = {
          fontDefault = "DejaVu Sans";
          fontFixed = "FiraCode Nerd Font Mono";
          panelBackgroundOpacity = 1;
        };
      };
      systemd.enable = true;
    };
    # File manager
    programs.yazi = {
      enable = true;
      extraPackages = with pkgs; [
        # recycle-bin
        trash-cli
      ];
      initLua = ''
        require("full-border"):setup({
          type = ui.Border.ROUNDED,
        })
        require("gvfs"):setup({})
        require("recycle-bin"):setup({})
      '';
      keymap = {
        mgr.prepend_keymap = [
          {
            run = ''shell "$SHELL" --block'';
            on = [ "!" ];
            desc = "Open $SHELL here";
          }
          {
            run = "plugin chmod";
            on = [ ">" "c" ];
            desc = "Chmod on selected files";
          }
          {
            run = "plugin mount";
            on = [ ">" "m" ];
            desc = "Mount/unmount disk";
          }
          {
            run = "plugin recycle-bin";
            on = [ ">" "r" ];
            desc = "Open Recycle Bin menu";
          }
          {
            run = "plugin gvfs -- add-mount";
            on = [ "<C-g>" "a" ];
            desc = "Add a GVFS mount URI";
          }
          {
            run = "plugin gvfs -- jump-back-prev-cwd";
            on = [ "<C-g>" "b" ];
            desc = "Jump back to position before jumped to device";
          }
          {
            run = "plugin gvfs -- automount-when-cd";
            on = [ "<C-g>" "c" ];
            desc = "Enable automount when cd to device under cwd";
          }
          {
            run = "plugin gvfs -- automount-when-cd --disabled";
            on = [ "<C-g>" "C" ];
            desc = "Disable automount when cd to device under cwd";
          }
          {
            run = "plugin gvfs -- edit-mount";
            on = [ "<C-g>" "e" ];
            desc = "Edit a GVFS mount URI";
          }
          {
            run = "plugin gvfs -- jump-to-device";
            on = [ "<C-g>" "j" ];
            desc = "Select device then jump to its mount point";
          }
          {
            run = "plugin gvfs -- jump-to-device --automount";
            on = [ "<C-g>" "J" ];
            desc = "Automount than select device to jump to its mount point";
          }
          {
            run = "plugin gvfs -- select-then-mount";
            on = [ "<C-g>M" "m" ];
            desc = "Select device then mount";
          }
          {
            run = "plugin gvfs -- select-then-mount --jump";
            on = [ "<C-g>" "M" ];
            desc = "Select device to mount and jump to its mount point";
          }
          {
            run = "plugin gvfs -- remove-mount";
            on = [ "<C-g>" "r" ];
            desc = "Remove a GVFS mount URI";
          }
          {
            run = "plugin gvfs -- remount-current-cwd-device";
            on = [ "<C-g>" "R" ];
            desc = "Remount device under cwd";
          }
          {
            run = "plugin gvfs -- select-then-unmount --eject";
            on = [ "<C-g>" "u" ];
            desc = "Select device than unmount";
          }
          {
            run = "plugin gvfs -- select-then-unmount --eject --force";
            on = [ "<C-g>" "U" ];
            desc = "Select device than force to unmount";
          }
          {
            run = "plugin toggle-pane max-preview";
            on = [ "P" ];
            desc = "How or hide the preview pane";
          }
        ];
      };
      plugins = {
        chmod = pkgs.yaziPlugins.chmod;
        full-border = pkgs.yaziPlugins.full-border;
        gvfs = yaziPlugins.gvfs;
        mount = pkgs.yaziPlugins.mount;
        recycle-bin = pkgs.yaziPlugins.recycle-bin;
        toggle-pane = pkgs.yaziPlugins.toggle-pane;
      };
      settings = {
        opener = {
          imv = lib.mkIf(config.programs.imv.enable) ([
            {
              run = ''imv "$@"'';
              orphan = true;
            }
          ]);
          zathura = lib.mkIf(config.programs.zathura.enable) ([
            {
              run = ''zathura "$@"'';
              orphan = true;
            }
          ]);
          mpv = lib.mkIf(config.programs.mpv.enable) ([
            {
              run = ''mpv "$@"'';
              orphan = true;
            }
          ]);
        };
        open = {
          rules = (if (config.programs.zathura.enable) then
            [
              {
                mime = "application/pdf";
                use = "zathura";
              }
              {
                mime = "application/postscript";
                use = "zathura";
              }
              {
                mime = "image/djvu";
                use = "zathura";
              }
            ]
          else [])
          ++(if (config.programs.imv.enable) then
            [
              {
                mime = "image/bmp";
                use = "imv";
              }
              {
                mime = "image/gif";
                use = "imv";
              }
              {
                mime = "image/jpeg";
                use = "imv";
              }
              {
                mime = "image/jpg";
                use = "imv";
              }
              {
                mime = "image/pjpeg";
                use = "imv";
              }
              {
                mime = "image/png";
                use = "imv";
              }
              {
                mime = "image/tiff";
                use = "imv";
              }
              {
                mime = "image/webp";
                use = "imv";
              }
              {
                mime = "image/x-*";
                use = "imv";
              }
              {
                mime = "image/heic";
                use = "imv";
              }
            ]
          else [])
          ++(if (config.programs.mpv.enable) then
            [
              {
                mime = "video/*";
                use = "mpv";
              }
            ]
          else []);
        };
        mgr.ratio = [3 5 0];
      };
      theme = {
        flavor = {
          dark = "noctalia";
          light = "noctalia";
        };
      };
    };
    # Document viewer
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
    };
    # Enable zen browser transparency and custom layout
    programs.zen-browser.profiles.default.settings = lib.mkIf config.devlive.programs.zen-browser.enable {
      "browser.tabs.inTitlebar" = if (desktop.noctalia.compositor == "hyprland") then 0 else 2;
      "zen.view.compact.hide-tabbar" = true;
      "zen.view.compact.hide-toolbar" = false;
      "zen.view.grey-out-inactive-windows" = false;
      "zen.widget.linux.transparency" = if (desktop.noctalia.compositor == "hyprland") then true else false;
    };
    wayland.windowManager.hyprland = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
      settings = {
        source = [
          "${config.xdg.configHome}/hypr/autostart.conf"
          "${config.xdg.configHome}/hypr/binds.conf"
          "${config.xdg.configHome}/hypr/common.conf"
          "${config.xdg.configHome}/hypr/env.conf"
          "${config.xdg.configHome}/hypr/input.conf"
          "${config.xdg.configHome}/hypr/laf.conf"
          "${config.xdg.configHome}/hypr/permissions.conf"
          "${config.xdg.configHome}/hypr/rules.conf"
          "${config.xdg.configHome}/hypr/noctalia/noctalia-colors.conf"
        ];
      };
    };

    xdg.configFile."hypr/autostart.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/autostart.conf;
    };
    xdg.configFile."hypr/binds.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/binds.conf;
    };
    xdg.configFile."hypr/common.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/common.conf;
    };
    xdg.configFile."hypr/env.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/env.conf;
    };
    xdg.configFile."hypr/input.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/input.conf;
    };
    xdg.configFile."hypr/laf.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/laf.conf;
    };
    xdg.configFile."hypr/permissions.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/permissions.conf;
    };
    xdg.configFile."hypr/rules.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/rules.conf;
    };

    xdg.configFile."niri/config.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/config.kdl;
    };
    xdg.configFile."niri/binds.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/binds.kdl;
    };
    xdg.configFile."niri/output.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/output.kdl;
    };

    services.flameshot = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          useGrimAdapter = true;
        };
      };
    };
    services.hypridle = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          lock_cmd = "noctalia-shell ipc call lockScreen lock";
        };
        listener = [
          # Lock the screen
          {
            # 5 minutes
            timeout = 300;
            on-timeout = "noctalia-shell ipc call lockScreen lock";
          }
          # Turn off the screen
          {
            # 15 minutes
            timeout = 900;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
    services.swayidle = lib.mkIf (desktop.noctalia.compositor == "niri") {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "${(lib.getExe config.programs.noctalia-shell.package)} ipc call lockScreen lock";
        }
        {
          timeout = 900;
          command = "${(lib.getExe pkgs.niri)} msg action power-off-monitors";
          resumeCommand = "${(lib.getExe pkgs.niri)} msg power-on-monitors";
        }
      ];
    };
    services.tailscale-systray.enable = true;
    services.udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "ghostty -e yazi";
        };
      };
      tray = "always";
    };

    dconf.settings."org/gnome/desktop/interface".gtk-theme = "adw-gtk3";
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    systemd.user.services.networkmanagerapplet = {
      Unit = {
        Description = "NetworkManager applet";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/postscript" = "org.pwmt.zathura.desktop";
      "image/vnd.djvu" = "org.pwmt.zathura.desktop";

      "image/bmp" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/jpg" = "imv.desktop";
      "image/pjpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/tiff" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/x-bmp" = "imv.desktop";
      "image/x-pcx" = "imv.desktop";
      "image/x-png" = "imv.desktop";
      "image/x-portable-anymap" = "imv.desktop";
      "image/x-portable-bitmap" = "imv.desktop";
      "image/x-portable-graymap" = "imv.desktop";
      "image/x-portable-pixmap" = "imv.desktop";
      "image/x-tga" = "imv.desktop";
      "image/x-xbitmap" = "imv.desktop";
      "image/heic" = "imv.desktop";
    };
  };
}
