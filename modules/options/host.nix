{ lib, ... }:

{
  options.devlive.host = {
    timeZone = lib.mkOption {
      type = lib.types.str;
    };
    defaultLocale = lib.mkOption {
      type = lib.types.str;
    };
  };
}
