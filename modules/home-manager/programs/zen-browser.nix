{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.zen-browser;
in
{
  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      profiles."default" = {
        containersForce = true;
        containers = {
          Personal = {
            color = "blue";
            icon = "fingerprint";
            id = 1;
          };
          Work = {
            color = "orange";
            icon = "briefcase";
            id = 2;
          };
          Banking = {
            color = "green";
            icon = "dollar";
            id = 3;
          };
          Shopping = {
            color = "pink";
            icon = "cart";
            id = 4;
          };
          "Dev-1" = {
            color = "red";
            icon = "circle";
            id = 5;
          };
          "Dev-2" = {
            color = "red";
            icon = "circle";
            id = 6;
          };
          "Dev-3" = {
            color = "red";
            icon = "circle";
            id = 7;
          };
          "Dev-4" = {
            color = "red";
            icon = "circle";
            id = 8;
          };
          "Dev-5" = {
            color = "red";
            icon = "circle";
            id = 9;
          };
        };
      };
    };
  };
}
