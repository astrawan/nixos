{ pkgs, ... }:

{
  imports = [
    ../../modules/options
  ];

  devlive.wsl.enable = true;

  devlive.host = {
    timeZone = "Asia/Makassar";
    defaultLocale = "en_US.UTF-8";
  };

  devlive.user = {
    name = "astra";
    fullName = "Astrawan Wayan";
    groups = [ "wheel" ];
    email = "astra@pm.me";
    packages = with pkgs; [
      home-manager
    ];
  };

  devlive.features.core-utils.enable = true;
  devlive.features.devel-utils.enable = true;

  devlive.programs.bash.enable = true;
  devlive.programs.gnupg.enable = true;
  devlive.programs.lazygit.enable = true;
  devlive.programs.tmux.enable = true;

  devlive.virtualisation.podman.enable = true;
}
