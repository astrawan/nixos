{ config, lib, pkgs, ... }:

let 
  cfg = config.devlive.features.devel-utils;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ast-grep
      inotify-tools
      tree-sitter
    ]
    ++ (
      if config.devlive.features.desktop.gnome.enable then
        with pkgs; [cartero dbeaver-bin gaphor]
      else
        []
    );

    programs.fd.enable = true;
    programs.fzf.enable = true;
    programs.neovim.enable = true;
    programs.ripgrep.enable = true;

    devlive.programs.lazygit.enable = true;
  };
}
