{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.deja-dup;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      deja-dup
    ];

    dconf.settings."org/gnome/deja-dup".exclude-list = cfg.exclude-list;
    dconf.settings."org/gnome/deja-dup".include-list = cfg.include-list;
    dconf.settings."org/gnome/deja-dup".backend =
      if cfg.google.enable then
        "google"
      else
        "";
    dconf.settings."org/gnome/deja-dup/google".folder = cfg.google.folder;
    dconf.settings."org/gnome/deja-dup".periodic = cfg.periodic;
  };
}
