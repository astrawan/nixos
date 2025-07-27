{ config, lib, ... }:

let
  cfg = config.devlive.user;
in 
{
  options.devlive.user = {
    name = lib.mkOption {
      type = lib.types.str;
    };
    fullName = lib.mkOption {
      type = lib.types.str;
    };
    groups = lib.mkOption {
      type = with lib.types; listOf str;
    };
    email = lib.mkOption {
      type = lib.types.str;
    };
    packages = lib.mkOption {
      type = with lib.types; listOf package;
    };
  };
}
