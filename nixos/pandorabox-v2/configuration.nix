# vi: sw=2 ts=2 et
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };
  # boot.loader.timeout = 0;

  networking.hostName = "pandorabox-v2"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.networkmanager.settings = {
  #   logging = {
  #     audit = true;
  #     level = "DEBUG";
  #   };
  # };

  # Set your time zone.
  time.timeZone = "Asia/Makassar";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "astra";
  };
  environment.gnome.excludePackages = (with pkgs; [
    decibels
    geary
    gnome-console
    gnome-music
    totem
  ]);

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.auditd.enable = true;
  security.audit = {
    enable = true;
    rules = [];
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable flatpak
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # NOTE: fix autologin not working when boot.initrd.systemd is enabled
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;


  services.tailscale = {
    disableTaildrop = true;
    enable = true;
    openFirewall = false;
    # if not working use command: tailscale up --netfilter-mode=off --login=<controlplane address>
    extraUpFlags = ["--netfilter-mode=off"];
  };

  services.usbguard = {
    enable = true;
    IPCAllowedGroups = [ "wheel" ];
  };

  # Enable docker
  virtualisation.docker = {
    enable = true;
    # disable opening container port to public
    daemon.settings = {
      # iptables = false;
      ip = "127.0.0.1";
    };

    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    #   daemon.settings = {
    #     dns = [ "1.1.1.1" "8.8.8.8" ];
    #     registry-mirrors = [ "https://mirror.gcr.io" ];
    #   };
    # };
  };

  # Enable podman
  # virtualisation.containers.enable = true;
  # virtualisation = {
  #   podman = {
  #     enable = true;
  #
  #     # Create a `docker` alias for podman, to use it as a drop-in replacement
  #     dockerCompat = true;
  #
  #     # Required for containers under podman-compose to be able to talk to each other.
  #     defaultNetwork.settings.dns_enabled = true;
  #   };
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.astra = {
    isNormalUser = true;
    description = "Astrawan Wayan";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      home-manager
    ];
  };

  # virtualisation
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.groups.libvirtd.members = ["astra"];
  programs.virt-manager.enable = true;


  # Install firefox.
  # programs.firefox.enable = true;

  # Install hyprland
  # programs.hyprland.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    adwaita-qt
    adwaita-qt6
    efibootmgr
    file
    gnomeExtensions.appindicator
    gnomeExtensions.logo-menu
    gnomeExtensions.tiling-shell
    gnomeExtensions.tailscale-qs
    gnome-software
    nixos-artwork.wallpapers.simple-blue
    podman-compose
    ptyxis
    usbguard-notifier
    vim
  ];

  environment.sessionVariables = {
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  # programs.sysdig.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = false;
    # listenAddresses = [
    #  {
    #    addr = "192.168.122.1";
    #    port = 22;
    #  }
    #];
  };

  services.cron.enable = true;
  services.fwupd.enable = true;
  services.opensnitch.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
    # extraCommands = '''';
    # extraStopCommands = '''';
    interfaces = {
      # virtualisation NAT interface
      virbr0 = {
        allowedTCPPorts = [ 22 5432 6379 8080 ];
      };
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
