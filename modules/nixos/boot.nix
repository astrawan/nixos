{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (!config.devlive.wsl.enable) {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    # boot.loader.grub = {
    #   enable = true;
    #   efiSupport = true;
    #   # efiInstallAsRemovable = true;
    #   device = "nodev";
    # };
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # playmouth
    boot.consoleLogLevel = 3;
    boot.initrd.systemd.enable = true;
    boot.initrd.verbose = false;
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 0;
    };
    boot.kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  boot.blacklistedKernelModules = [ "mmc_block" ];
    boot.plymouth = {
      enable = true;
      theme = "bgrt";
    };

    # boot.loader.timeout = 0;
  };
}
