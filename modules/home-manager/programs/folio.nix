{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.folio;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      folio
    ];

    dconf.settings."com/toolstack/Folio".enable-autosave = cfg.enable-autosave;
    dconf.settings."com/toolstack/Folio".notes-dir =
      if cfg.notes-dir != "" then
        cfg.notes-dir
      else
        "/home/${config.devlive.user.name}/Documents/Folio/Notes";
    dconf.settings."com/toolstack/Folio".note-font =
      if cfg.note-font != "" then
        cfg.note-font
      else
        "Adwaita Sans 11";
    dconf.settings."com/toolstack/Folio".note-font-monospace =
      if cfg.note-font-monospace != "" then
        cfg.note-font-monospace
      else
        "Adwaita Mono Regular 11";
    dconf.settings."com/toolstack/Folio".trash-dir =
      if cfg.trash-dir != "" then
        cfg.trash-dir
      else
        "/home/${config.devlive.user.name}/Documents/Folio/Trash";
  };
}
