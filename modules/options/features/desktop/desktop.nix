{ config, lib, ... }:

{
  options.devlive.features.desktop = {
    type = lib.mkOption {
      type = lib.types.enum [
        "gnome"
        "noctalia"
      ];
      default = "gnome";
      description = "Default desktop to use";
      example = "gnome";
    };
    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      example = lib.lieteralExpression ''
        with pkgs; [
          imv
          mpv
          yazi
        ]
      '';
      description = ''
        Extra packages to make avaiable to desktop
      '';
    };
    extraHomePackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      example = lib.lieteralExpression ''
        with pkgs; [
          imv
          mpv
          yazi
        ]
      '';
      description = ''
        Extra packages to make avaiable to desktop via home-manager
      '';
    };
  };
}
