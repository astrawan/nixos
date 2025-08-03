{ config, lib, ... }:

let
  cfg = config.devlive.programs.keystore-explorer;
in
{
  options.devlive.programs.keystore-explorer = {
    enable = lib.mkEnableOption "tmux";
  };
}
