{ lib, ... }:

{
  options.devlive.virtualisation.waydroid = {
    enable = lib.mkEnableOption "waydroid";
  };
}
