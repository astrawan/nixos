{ pkgs, ... }:

{
  devlive.host = {
    timeZone = "Asia/Makassar";
    defaultLocale = "en_US.UTF-8";
  };

  devlive.user = {
    name = "astra";
    fullName = "Astrawan Wayan";
    groups = [ "networkmanager" "wheel" ];
    email = "astra@pm.me";
    packages = with pkgs; [
      home-manager
    ];
  };

  devlive.features.core-utils.enable = true;
  devlive.features.devel-utils.enable = true;

  devlive.programs.bash.enable = true;
  devlive.programs.gnupg.enable = true;

  devlive.virtualisation.podman.enable = true;
}
