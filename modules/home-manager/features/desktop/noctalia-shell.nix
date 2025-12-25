{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.noctalia-shell;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      adw-gtk3
      adwaita-icon-theme
      adwaita-fonts
      bazaar
      freerdp
      gimp
      kdePackages.breeze-icons
      kdePackages.qt6ct
      inkscape
      nerd-fonts.fira-code
      telegram-desktop
      wl-clipboard
      zoom-us
    ];
    devlive.programs.ghostty.enable = true;
    programs.ghostty.settings.background-opacity = 0.9;
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
                id = "Taskbar";
                onlyActiveWorkspaces = false;
                onlySameOutput = false;
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
                id = "SystemMonitor";
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
                id = "ControlCenter";
                useDistroLogo = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Tokyo Night";
        general = {
          enableShadows = false;
          showScreenCorners = true;
        };
        location = {
          name = "Canggu, Indonesia";
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
          fontDefault = "FiraCode Nerd Font";
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
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$fileManager" = "$terminal -e yazi";
        "$mod" = "SUPER";
        "$terminal" = "ghostty";
        bind = [
          "$mod       , A                     , exec            , noctalia-shell ipc call launcher toggle"
          "$mod       , B                     , exec            , noctalia-shell ipc call bar toggle"
          "$mod       , C                     , killactive"
          "$mod       , E                     , exec            , $fileManager"
          "$mod       , F                     , fullscreen      , 1"
          "$mod       , M                     , exec            , noctalia-shell ipc call sessionMenu toggle"
          "$mod       , N                     , exec            , noctalia-shell ipc call notifications toggleHistory"
          "$mod       , Q                     , exec            , $terminal"
          "$mod       , R                     , exec            , noctalia-shell ipc call launcher toggle"
          "$mod       , S                     , exec            , noctalia-shell ipc call settings toggle"
          "$mod       , V                     , togglefloating"
          "$mod SHIFT , C                     , exec            , noctalia-shell ipc call controlCenter toggle"
          "$mod SHIFT , J                     , togglesplit"
          "$mod SHIFT , K                     , togglesplit"
          # move focus with $mod + arrow keys
          "$mod       , H                     , movefocus       , l"
          "$mod       , L                     , movefocus       , r"
          "$mod       , K                     , movefocus       , u"
          "$mod       , J                     , movefocus       , d"
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
        env = [
          "QT_QPA_PLATFORMTHEME,qt6ct"
        ];
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
            size = 5;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        general = {
          allow_tearing = false;
          border_size = 4;
          # based on tokyo night color pallete
          "col.active_border" = "rgba(f7768eff) rgba(e0af68ff) 45deg";
          "col.inactive_border" = "rgba(a9b1d6ff)";
          layout = "dwindle";
          resize_on_border = true;
        };
        layerrule = [
          "blur,com.mitchellh.ghostty"
        ];
        monitor = ",preferred,auto,1";
        windowrule = [
          "float,content photo,size 800 600,class:feh"
          "float,content video,size 800 600,class:mpv"
          "float,size 800 600,class:org.pwmt.zathura"
        ];
        workspace = [
          "1,persistent:true"
          "2,persistent:true"
          "3,persistent:true"
          "4,persistent:true"
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

    dconf.settings."org/gnome/desktop/interface".gtk-theme = "adw-gtk3";
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
