{ config, lib, ... }:

let
  cfg = config.devlive.wsl;
in 
{
  config = lib.mkIf cfg.enable {
    wsl.enable = true;
    wsl.defaultUser = config.devlive.user.name;
  };
}
