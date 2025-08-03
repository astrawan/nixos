{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.keystore-explorer;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      keystore-explorer
    ];

    xdg.desktopEntries.keystore-explorer = {
      name = "KeyStore Explorer";
      exec = "keystore-explorer";
      icon = "${pkgs.keystore-explorer.outPath}/share/keystore-explorer/icons/kse_256.png";
      genericName = "Multipurpose keystore and certificate tool";
      categories = [ "Utility" "Security" "System" "Java" ];
      comment = "User friendly GUI application for creating, managing and examining keystores, keys, certificates, certificate requests, certificate revocation lists and more.";
    };
  };
}
