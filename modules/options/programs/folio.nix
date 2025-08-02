{ config, lib, ... }:

let 
  cfg = config.devlive.programs.folio;
in
{
  options.devlive.programs.folio = {
    enable = lib.mkEnableOption "folio";
    enable-autosave = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Automatically saves the current note every 30 seconds if the contents have changed";
    };
    notes-dir = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Where the notebooks are stored";
    };
    note-font = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The font notes will be displayed in";
    };
    note-font-monospace = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The font code will be displayed in";
    };
    trash-dir = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Where the trash folder is located";
    };
  };
}
