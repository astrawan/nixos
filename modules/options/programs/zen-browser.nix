{ config, lib, ... }:

let
  cfg = config.devlive.programs.zen-browser;
in
{
  options.devlive.programs.zen-browser = {
    enable = lib.mkEnableOption "zen-browser";
  };
}
