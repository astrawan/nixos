{ config, lib, ... }:

let
  cfg = config.devlive.programs.deja-dup;
in
{
  options.devlive.programs.deja-dup = {
    enable = lib.mkEnableOption "deja-dup";
    exclude-list = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
    include-list = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };

    google = rec {
      enable = lib.mkEnableOption "deja-dup.google";
      folder = lib.mkOption {
        type = lib.types.str;
        default = "Documents";
      };
    };

    periodic = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
}
