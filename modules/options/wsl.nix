{ lib, ... }:

{
  options.devlive.wsl = {
    enable = lib.mkEnableOption "wsl";
  };
}
