{ config, lib, ... }:

let
  cfg = config.devlive.features.desktop.noctalia-shell;
in
{
  options.devlive.features.desktop.noctalia-shell = {
    enable = lib.mkEnableOption "noctalia-shell";
  };
}
