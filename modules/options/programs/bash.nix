{ config, lib, ... }:

let 
  cfg = config.devlive.programs.bash;
in
{
  options.devlive.programs.bash = {
    enable = lib.mkEnableOption "bash";
  };
}
