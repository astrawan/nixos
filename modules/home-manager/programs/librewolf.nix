{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.librewolf;
in
{
  config = lib.mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      enableGnomeExtensions = false;
      profiles."${config.devlive.user.name}" = {
        name = "${config.devlive.user.name}";
        isDefault = true;
        containers = {
          personal = {
            color = "blue";
            icon = "fingerprint";
            id = 1;
            name = "Personal";
          };
          pork = {
            color = "orange";
            icon = "briefcase";
            id = 2;
            name = "work";
          };
          banking = {
            color = "green";
            icon = "dollar";
            id = 3;
            name = "Banking";
          };
          shopping = {
            color = "pink";
            icon = "cart";
            id = 4;
            name = "Shopping";
          };
          dev1 = {
            color = "red";
            icon = "circle";
            id = 5;
            name = "Development-1";
          };
          dev2 = {
            color = "red";
            icon = "circle";
            id = 6;
            name = "Development-2";
          };
          dev3 = {
            color = "red";
            icon = "circle";
            id = 7;
            name = "Development-3";
          };
          dev4 = {
            color = "red";
            icon = "circle";
            id = 8;
            name = "Development-4";
          };
          dev5 = {
            color = "red";
            icon = "circle";
            id = 9;
            name = "Development-5";
          };
        };
        containersForce = true;
        settings = {
          "browser.tabs.inTitlebar" = 0;
          "browser.toolbars.bookmarks.visibility" = "never";
          "identity.fxaccounts.enabled" = true;
          "media.eme.enabled" = true;
          "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.visibility" = "expand-on-hover";
          "browser.uiCustomization.state" = ''{
            "placements": {
              "widget-overflow-fixed-list": [],
              "unified-extensions-area": [],
              "nav-bar": [
                "sidebar-button",
                "back-button",
                "forward-button",
                "urlbar-container",
                "vertical-spacer",
                "firefox-view-button",
                "unified-extensions-button",
                "ublock0_raymondhill_net-browser-action"
              ],
              "toolbar-menubar": [
                "menubar-items"
              ],
              "TabsToolbar": [],
              "vertical-tabs": [
                "tabbrowser-tabs"
              ],
              "PersonalToolbar": [
                "personal-bookmarks"
              ]
            },
            "seen": [
              "developer-button",
              "screenshot-button",
              "ublock0_raymondhill_net-browser-action"
            ],
            "dirtyAreaCache": [
              "nav-bar",
              "TabsToolbar",
              "vertical-tabs",
              "toolbar-menubar",
              "PersonalToolbar",
              "unified-extensions-area"
            ],
            "currentVersion": 23,
            "newElementCount": 8
          }'';
        };
        search = {
          default = "ddg";
          force = true;
          privateDefault = "ddg";
        };
      };
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };
}
