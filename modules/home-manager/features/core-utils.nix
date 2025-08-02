{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.core-utils;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dig
      ffmpeg
      p7zip-rar
      pciutils
      tcpdump
      unzip
      wget
    ];

    programs.starship.enable = true;
  };
}
