{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.noctalia-shell;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      adw-gtk3
      adwaita-icon-theme
      bazaar
      freerdp
      gimp
      # noctalia-shell gtk4 color schema integration
      glib
      kdePackages.breeze-icons
      kdePackages.qt6ct
      inkscape
      libsForQt5.qt5ct
      networkmanagerapplet
      qbittorrent
      telegram-desktop
      termscp
      wayclip
    ];
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
      background-opacity = 0.8;
      theme = "noctalia";
    };
    # System monitor
    programs.bottom.enable = true;
    # Image preview
    programs.feh = {
      enable = true;
      keybindings = {
        next_img = "Right";
        prev_img = "Left";
        zoom_in = "plus";
        zoom_out = "minus";
      };
    };
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
          allowPanelsOnScreenWithoutBar = false;
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
          niri = false;
          hyprland = true;
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
      settings = {
        opener = {
          image = [
            {
              run = ''feh "$@"'';
              orphan = true;
            }
          ];
          pdf = [
            {
              run = ''zathura "$@"'';
              orphan = true;
            }
          ];
          play = [
            {
              run = ''mpv "$@"'';
              orphan = true;
            }
          ];
        };
        open = {
          rules = [
            {
              mime = "application/pdf";
              use = "pdf";
            }
            {
              mime = "video/*";
              use = "play";
            }
            {
              mime = "image/*";
              use = "image";
            }
          ];
        };
      };
    };
    # Document viewer
    programs.zathura.enable = true;
    # Enable zen browser transparency and custom layout
    programs.zen-browser.profiles.default.settings = lib.mkIf config.devlive.programs.zen-browser.enable {
      "browser.tabs.inTitlebar" = 0;
      "zen.view.compact.hide-tabbar" = true;
      "zen.view.compact.hide-toolbar" = false;
      "zen.view.grey-out-inactive-windows" = false;
      "zen.widget.linux.transparency" = true;
    };
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$fileManager" = "$terminal -e yazi";
        "$mod" = "SUPER";
        "$sysMonitor" = "$terminal -e btm";
        "$terminal" = "ghostty";
        "$webBrowser" = "brave";
        "$webBrowserAlt" = "zen-beta";
        source = "${config.xdg.configHome}/hypr/noctalia/noctalia-colors.conf";
        bind = [
          "$mod       , A                     , exec            , noctalia-shell ipc call launcher toggle"
          "$mod       , B                     , exec            , noctalia-shell ipc call bar toggle"
          "$mod SHIFT , B                     , exec            , noctalia-shell ipc call battery togglePanel"
          "$mod       , C                     , killactive"
          "$mod SHIFT , C                     , exec            , noctalia-shell ipc call controlCenter toggle"
          "$mod SHIFT , D                     , exec            , noctalia-shell ipc call calendar toggle"
          "$mod       , E                     , exec            , $fileManager"
          "$mod       , F                     , fullscreen      , 1"
          "$mod       , M                     , exec            , $sysMonitor"
          "$mod SHIFT , N                     , exec            , noctalia-shell ipc call notifications toggleHistory"
          "$mod       , Q                     , exec            , $terminal"
          "$mod       , R                     , exec            , noctalia-shell ipc call launcher toggle"
          "$mod SHIFT , S                     , exec            , noctalia-shell ipc call settings toggle"
          "$mod       , V                     , togglefloating"

          "$mod SHIFT , H                     , movewindow      , l"
          "$mod SHIFT , L                     , movewindow      , r"
          "$mod SHIFT , K                     , movewindow      , u"
          "$mod SHIFT , J                     , movewindow      , d"
          "$mod       , H                     , movefocus       , l"
          "$mod       , L                     , movefocus       , r"
          "$mod       , K                     , movefocus       , u"
          "$mod       , J                     , movefocus       , d"

          "$mod       , W                     , exec            , $webBrowser"
          "$mod SHIFT , W                     , exec            , $webBrowserAlt"

          # Switch workspaces with $mod + [0-9]
          "$mod       , 1                     , workspace       , 1"
          "$mod       , 2                     , workspace       , 2"
          "$mod       , 3                     , workspace       , 3"
          "$mod       , 4                     , workspace       , 4"
          "$mod       , 5                     , workspace       , 5"
          "$mod       , 6                     , workspace       , 6"
          "$mod       , 7                     , workspace       , 7"
          "$mod       , 8                     , workspace       , 8"
          "$mod       , 9                     , workspace       , 9"
          # Move active window to a workspace with $mod + SHIFT + [0-9]
          "$mod SHIFT , 1                     , movetoworkspace , 1"
          "$mod SHIFT , 2                     , movetoworkspace , 2"
          "$mod SHIFT , 3                     , movetoworkspace , 3"
          "$mod SHIFT , 4                     , movetoworkspace , 4"
          "$mod SHIFT , 5                     , movetoworkspace , 5"
          "$mod SHIFT , 6                     , movetoworkspace , 6"
          "$mod SHIFT , 7                     , movetoworkspace , 7"
          "$mod SHIFT , 8                     , movetoworkspace , 8"
          "$mod SHIFT , 9                     , movetoworkspace , 9"

          # Move active monitor focus with $mod + ('[' or ']')
          "$mod       , BRACKETLEFT           , focusmonitor    , -1"
          "$mod       , BRACKETRIGHT          , focusmonitor    , +1"

          "CTRL ALT   , DELETE                , exec            , noctalia-shell ipc call sessionMenu toggle"
          "CTRL ALT   , L                     , exec            , noctalia-shell ipc call lockScreen lock"
          "           , PRINT                 , exec            , flameshot gui"
        ];
        bindm = [
          # Move/resize windows with $mod + LMB/RMB and dragging
          "$mod       , mouse:272             , movewindow"
          "$mod SHIFT , mouse:273             , resizewindow"
        ];
        bindel = [
          # Laptop multimedia keys for volume and LCD brightness
          "           , XF86AudioRaiseVolume  , exec            , noctalia-shell ipc call volume increase"
          "           , XF86AudioLowerVolume  , exec            , noctalia-shell ipc call volume decrease"
          "           , XF86AudioMute         , exec            , noctalia-shell ipc call volume muteOutput"
          "           , XF86AudioMicMute      , exec            , noctalia-shell ipc call volume muteInput"
          "           , XF86MonBrightnessUp   , exec            , noctalia-shell ipc call brightness increase"
          "           , XF86MonBrightnessDown , exec            , noctalia-shell ipc call brightness decrease"
        ];
        bindl = [
          "           , XF86AudioNext         , exec            , noctalia-shell ipc call media next"
          "           , XF86AudioPause        , exec            , noctalia-shell ipc call media pause"
          "           , XF86AudioPlay         , exec            , noctalia-shell ipc call media play"
          "           , XF86AudioPrev         , exec            , noctalia-shell ipc call media previous"
        ];
        binds = {
          # Enable move window focus on fullscreen mode
          movefocus_cycles_fullscreen = true;
        };
        decoration = {
          rounding = 14;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 7;
            passes = 3;
            ignore_opacity = true;
            noise = 0.08;
            contrast = 1.5;
            xray = false;
            new_optimizations = true;
          };
        };
        general = {
          allow_tearing = false;
          border_size = 4;
          layout = "dwindle";
          resize_on_border = true;
        };
        layerrule = [
          "blur,com.mitchellh.ghostty"
          "blur,zen-beta"
        ];
        monitor = ",preferred,auto,1";
        windowrule = [
          # Brave browser dialog
          "float,content photo,size 800 600,class:brave"
          "float,content photo,size 800 600,class:feh"
          "float,content video,size 800 600,class:mpv"
          "float,size 800 600,class:org.pwmt.zathura"
          "float,size 800 600,class:nm-connection-editor"
          "float,size 800 600,class:nm-openconnect-auth-dialog"
        ];
        workspace = [
          "1,persistent:true"
          "2,persistent:true"
          "3,persistent:true"
          "4,persistent:true"
          "5,persistent:true"
          "6,persistent:true"
          "7,persistent:true"
          "8,persistent:true"
          "9,persistent:true"
        ];
      };
    };

    services.flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          useGrimAdapter = true;
        };
      };
    };
    services.hypridle = {
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
    services.tailscale-systray.enable = true;
    services.udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "ghostty -e yazi";
        };
      };
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

      "image/bmp" = "feh.desktop";
      "image/gif" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/jpg" = "feh.desktop";
      "image/pjpeg" = "feh.desktop";
      "image/png" = "feh.desktop";
      "image/tiff" = "feh.desktop";
      "image/webp" = "feh.desktop";
      "image/x-bmp" = "feh.desktop";
      "image/x-pcx" = "feh.desktop";
      "image/x-png" = "feh.desktop";
      "image/x-portable-anymap" = "feh.desktop";
      "image/x-portable-bitmap" = "feh.desktop";
      "image/x-portable-graymap" = "feh.desktop";
      "image/x-portable-pixmap" = "feh.desktop";
      "image/x-tga" = "feh.desktop";
      "image/x-xbitmap" = "feh.desktop";
      "image/heic" = "feh.desktop";
    };
  };
}
