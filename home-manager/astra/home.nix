# vi: sw=2 ts=2 et
{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${config.devlive.user.name}";
  home.homeDirectory = "/home/${config.devlive.user.name}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (
    if config.devlive.features.desktop.gnome.enable then
      with pkgs; [
        aegisub
        gradia
        libreoffice
        popcorntime
        wireshark
        wl-clipboard
      ]
    else
      []
  );

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/astra/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };
  xdg.mimeApps.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "${config.devlive.user.email}";
    userName = "${config.devlive.user.fullName}";
    extraConfig = {
      commit = {
        gpgsign = true;
      };
      fetch = {
        prune = true;
      };
      tag = {
        forceSignAnnotated = true;
      };
      user = {
        signingkey = "A6113EB4F50442EA";
      };
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "bitbucket.stack.devlive.cloud" = {
        hostname = "bitbucket.stack.devlive.cloud";
        port = 22;
        user = "git";
        identityFile = "~/Vaults/SSH/id_ed25519_sk_git_1";
      };
      "firewall.node.vpn.devlive.cloud" = {
        hostname = "firewall.node.vpn.devlive.cloud";
        port = 2222;
        user = "puffy";
        identityFile = "~/Vaults/SSH/id_ed25519_sk_srv_1";
      };
      "gitlab.com" = {
        hostname = "gitlab.com";
        port = 22;
        user = "astrawan";
        identityFile = "~/Vaults/SSH/id_ed25519_sk_git_1";
      };
      "github.com" = {
        hostname = "github.com";
        port = 22;
        user = "git";
        identityFile = "~/Vaults/SSH/id_ed25519_sk_git_1";
      };
      "controlplane.node.devlive.cloud.1" = {
        hostname = "controlplane.node.devlive.cloud";
        port = 22;
        user = "ubuntu";
        identityFile = "~/Vaults/SSH/id_ed25519_sk_srv_1";
      };
      "controlplane.node.devlive.cloud.2" = {
        hostname = "controlplane.node.devlive.cloud";
        port = 22;
        user = "vpnadmin";
        identityFile = "~/Vaults/SSH/id_ed25519_sk_srv_1";
      };
    };
    extraConfig = "
Host localhost
  HostName    localhost
  Port        8101
  HostKeyAlgorithms=+ssh-rsa
Host localhost
  HostName    localhost
  Port        8102
  HostKeyAlgorithms=+ssh-rsa
Host localhost
  HostName    localhost
  Port        8103
  HostKeyAlgorithms=+ssh-rsa
Host localhost
  HostName    localhost
  Port        8104
  HostKeyAlgorithms=+ssh-rsa
Host localhost
  HostName    localhost
  Port        8105
  HostKeyAlgorithms=+ssh-rsa
Host localhost
  HostName    localhost
  Port        8106
  HostKeyAlgorithms=+ssh-rsa
    ";
  };
}
