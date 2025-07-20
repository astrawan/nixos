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

  boot.initrd.luks.devices."luks-cd64b8dc-54f2-4d38-b7b4-e1d83c5e18e9".device = "/dev/disk/by-uuid/cd64b8dc-54f2-4d38-b7b4-e1d83c5e18e9";

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

  networking.hostName = "pandorabox"; # Define your hostname.
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
    listenAddresses = [
      {
        addr = "192.168.122.1";
        port = 22;
      }
    ];
  };

  services.cron.enable = true;
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
    extraCommands = ''
      iptables -N ts-forward || true
      ip6tables -N ts-forward || true
      iptables -N ts-input || true
      ip6tables -N ts-input || true

      iptables -A INPUT -j ts-input || true
      ip6tables -A INPUT -j ts-input || true
      iptables -A FORWARD -j ts-forward || true
      ip6tables -A FORWARD -j ts-forward || true

      iptables -A ts-forward -i tailscale0 -j MARK --set-xmark 0x40000/0xff0000 || true
      ip6tables -A ts-forward -i tailscale0 -j MARK --set-xmark 0x40000/0xff0000 || true
      iptables -A ts-forward -m mark --mark 0x40000/0xff0000 -j ACCEPT || true
      ip6tables -A ts-forward -m mark --mark 0x40000/0xff0000 -j ACCEPT || true
      iptables -A ts-forward -s 100.64.0.0/10 -o tailscale0 -j DROP || true
      iptables -A ts-forward -o tailscale0 -j ACCEPT || true
      ip6tables -A ts-forward -o tailscale0 -j ACCEPT || true
      iptables -A ts-input -s 100.64.0.21/32 -i lo -j ACCEPT || true
      ip6tables -A ts-input -s fd7a:115c:a1e0::15/128 -i lo -j ACCEPT
      iptables -A ts-input -s 100.115.92.0/23 ! -i tailscale0 -j RETURN || true
      iptables -A ts-input -s 100.64.0.0/10 ! -i tailscale0 -j DROP || true
      iptables -A ts-input -i tailscale0 -j nixos-fw || true
      ip6tables -A ts-input -i tailscale0 -j nixos-fw || true
      iptables -A ts-input -p udp -m udp --dport 41641 -j ACCEPT || true
      ip6tables -A ts-input -p udp -m udp --dport 41641 -j ACCEPT || true
    '';
    extraStopCommands = ''
      iptables -D ts-forward -i tailscale0 -j MARK --set-xmark 0x40000/0xff0000 || true
      ip6tables -D ts-forward -i tailscale0 -j MARK --set-xmark 0x40000/0xff0000 || true
      iptables -D ts-forward -m mark --mark 0x40000/0xff0000 -j ACCEPT || true
      ip6tables -D ts-forward -m mark --mark 0x40000/0xff0000 -j ACCEPT || true
      iptables -D ts-forward -s 100.64.0.0/10 -o tailscale0 -j DROP || true
      iptables -D ts-forward -o tailscale0 -j ACCEPT || true
      ip6tables -D ts-forward -o tailscale0 -j ACCEPT || true
      iptables -D ts-input -s 100.64.0.21/32 -i lo -j ACCEPT || true
      ip6tables -D ts-input -s fd7a:115c:a1e0::15/128 -i lo -j ACCEPT
      iptables -D ts-input -s 100.115.92.0/23 ! -i tailscale0 -j RETURN || true
      iptables -D ts-input -s 100.64.0.0/10 ! -i tailscale0 -j DROP || true
      iptables -D ts-input -i tailscale0 -j nixos-fw || true
      ip6tables -D ts-input -i tailscale0 -j nixos-fw || true
      iptables -D ts-input -p udp -m udp --dport 41641 -j ACCEPT || true
      ip6tables -D ts-input -p udp -m udp --dport 41641 -j ACCEPT || true

      iptables -D INPUT -j ts-input || true
      ip6tables -D INPUT -j ts-input || true
      iptables -D FORWARD -j ts-forward || true
      ip6tables -D FORWARD -j ts-forward || true

      iptables -X ts-forward || true
      ip6tables -X ts-forward || true
      iptables -X ts-input || true
      ip6tables -X ts-input || true
    '';
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
