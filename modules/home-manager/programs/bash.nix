{ config, lib, ... }:

let 
  cfg = config.devlive.programs.bash;
in
{
  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      '';
    };
  };
}
