{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.desktop.gnome;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gnomeExtensions.tiling-shell
    ];

    dconf.settings."org/gnome/shell/extensions/tilingshell" = {
      enable-window-border = false;
      enable-smart-window-border-radius = true;
      layouts-json = ''
        [
          {
            "id": "Layout 1",
            "tiles": [
              {
                "x": 0,
                "y": 0,
                "width": 0.5,
                "height": 1,
                "groups": [
                  1
                ]
              },
              {
                "x": 0.5,
                "y": 0,
                "width": 0.5000000000000002,
                "height": 0.5,
                "groups": [
                  2,
                  1
                ]
              },
              {
                "x": 0.5,
                "y": 0.5,
                "width": 0.5000000000000002,
                "height": 0.5,
                "groups": [
                  2,
                  1
                ]
              }
            ]
          },
          {
            "id": "Layout 2",
            "tiles": [
              {
                "x": 0,
                "y": 0,
                "width": 0.5,
                "height": 0.5,
                "groups": [
                  1,
                  2
                ]
              },
              {
                "x": 0.5,
                "y": 0,
                "width": 0.5000000000000007,
                "height": 1,
                "groups": [
                  1
                ]
              },
              {
                "x": 0,
                "y": 0.5,
                "width": 0.5,
                "height": 0.5000000000000002,
                "groups": [
                  2,
                  1
                ]
              }
            ]
          },
          {
            "id": "Layout 3",
            "tiles": [
              {
                "x": 0,
                "y": 0,
                "width": 0.5,
                "height": 0.5,
                "groups": [
                  1,
                  2
                ]
              },
              {
                "x": 0.5,
                "y": 0,
                "width": 0.5000000000000002,
                "height": 0.5,
                "groups": [
                  3,
                  1
                ]
              },
              {
                "x": 0,
                "y": 0.5,
                "width": 0.5,
                "height": 0.5000000000000002,
                "groups": [
                  2,
                  1
                ]
              },
              {
                "x": 0.5,
                "y": 0.5,
                "width": 0.5000000000000002,
                "height": 0.5,
                "groups": [
                  3,
                  1
                ]
              }
            ]
          },
          {
            "id": "Layout 4",
            "tiles": [
              {
                "x": 0,
                "y": 0,
                "width": 0.22,
                "height": 0.5,
                "groups": [
                  1,
                  2
                ]
              },
              {
                "x": 0,
                "y": 0.5,
                "width": 0.22,
                "height": 0.5,
                "groups": [
                  1,
                  2
                ]
              },
              {
                "x": 0.22,
                "y": 0,
                "width": 0.56,
                "height": 1,
                "groups": [
                  2,
                  3
                ]
              },
              {
                "x": 0.78,
                "y": 0,
                "width": 0.22,
                "height": 0.5,
                "groups": [
                  3,
                  4
                ]
              },
              {
                "x": 0.78,
                "y": 0.5,
                "width": 0.22,
                "height": 0.5,
                "groups": [
                  3,
                  4
                ]
              }
            ]
          },
          {
            "id": "Layout 5",
            "tiles": [
              {
                "x": 0,
                "y": 0,
                "width": 0.22,
                "height": 1,
                "groups": [
                  1
                ]
              },
              {
                "x": 0.22,
                "y": 0,
                "width": 0.56,
                "height": 1,
                "groups": [
                  1,
                  2
                ]
              },
              {
                "x": 0.78,
                "y": 0,
                "width": 0.22,
                "height": 1,
                "groups": [
                  2
                ]
              }
            ]
          },
          {
            "id": "Layout 6",
            "tiles": [
              {
                "x": 0,
                "y": 0,
                "width": 0.33,
                "height": 1,
                "groups": [
                  1
                ]
              },
              {
                "x": 0.33,
                "y": 0,
                "width": 0.67,
                "height": 1,
                "groups": [
                  1
                ]
              }
            ]
          },
          {
            "id": "Layout 7",
            "tiles": [
              {
                "x": 0,
                "y": 0,
                "width": 0.67,
                "height": 1,
                "groups": [
                  1
                ]
              },
              {
                "x": 0.67,
                "y": 0,
                "width": 0.33,
                "height": 1,
                "groups": [
                  1
                ]
              }
            ]
          }
        ]
      '';
      untile-window = ["<Control>Return"];
    };
  };
}
