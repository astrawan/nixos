{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.yubikey;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      yubioath-flutter
    ];
  };
}
