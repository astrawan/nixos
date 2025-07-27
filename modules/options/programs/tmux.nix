{ config, lib, ... }:

let
  cfg = config.devlive.programs.tmux;
in
{
  options.devlive.programs.tmux = {
    enable = lib.mkEnableOption "tmux";
  };
}
