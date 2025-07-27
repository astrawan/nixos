{ config, lib, ... }:

let
  cfg = config.devlive.virtualisation.libvirtd;
in
{
  config = lib.mkIf cfg.enable {
    # virtualisation
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    users.groups.libvirtd.members = ["${config.devlive.user.name}"];
    programs.virt-manager.enable = true;
  };
}
